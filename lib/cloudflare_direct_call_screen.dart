import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_demo/cloudflare_sfu_service.dart';

class CloudflareDirectCallScreen extends StatefulWidget {
  const CloudflareDirectCallScreen({super.key});

  @override
  State<CloudflareDirectCallScreen> createState() =>
      _CloudflareDirectCallScreenState();
}

class _CloudflareDirectCallScreenState
    extends State<CloudflareDirectCallScreen> {
  final _cfService = CloudflareSfuService();

  // WebRTC Renderers
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  // Local State Keys to share
  String _mySessionId = "Not Created";
  String _myTrackId = "Not Created";

  // Inputs for connecting to the other side
  final TextEditingController _remoteTrackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  /// PHASE A: CREATE THE CALL & BROADCAST YOUR TRACk
  Future<void> _startBroadcasting() async {
    try {
      // Check available media devices
      final devices = await navigator.mediaDevices.enumerateDevices();
      bool hasVideo = false;
      bool hasAudio = false;
      for (var device in devices) {
        if (device.kind == 'videoinput') {
          hasVideo = true;
        } else if (device.kind == 'audioinput') {
          hasAudio = true;
        }
      }

      if (!hasVideo && !hasAudio) {
        throw Exception(
          "NotFoundError: No audio or video input devices found.",
        );
      }

      // 1. Open local camera and microphone dynamically
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': hasAudio,
        'video': hasVideo ? {'facingMode': 'user'} : false,
      });
      _localRenderer.srcObject = _localStream;

      // 2. Setup the WebRTC peer connection pointing to Cloudflare's STUN
      _peerConnection = await createPeerConnection({
        'iceServers': [
          {
            'urls': ['stun:stun.cloudflare.com:3478'],
          },
        ],
      });

      // Pass tracks to the connection pipeline
      _localStream!.getTracks().forEach((track) {
        _peerConnection!.addTrack(track, _localStream!);
      });

      // Handle displaying incoming streams when we subscribe to a remote user
      _peerConnection!.onTrack = (RTCTrackEvent event) {
        if (event.streams.isNotEmpty && event.track.kind == 'video') {
          setState(() {
            _remoteRenderer.srcObject = event.streams[0];
          });
        }
      };

      // 3. Create WebRTC offer and initialize Session on Cloudflare
      RTCSessionDescription localOffer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(localOffer);

      final sessionResult = await _cfService.createSession(localOffer.sdp!);
      String sessionId = sessionResult['sessionId'];
      String sessionAnswerSdp = sessionResult['sdp'];

      // Apply Cloudflare's session configuration answer
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(sessionAnswerSdp, 'answer'),
      );

      // 4. Create an offer to push your local track up into Cloudflare
      RTCSessionDescription trackOffer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(trackOffer);

      // Extract transceivers to build local tracks specification for Cloudflare
      final transceivers = await _peerConnection!.getTransceivers();
      List<Map<String, dynamic>> tracksToPush = [];
      for (var transceiver in transceivers) {
        final track = transceiver.sender.track;
        if (track != null) {
          tracksToPush.add({
            "location": "local",
            "mid": transceiver.mid,
            "trackName": track.id ?? '',
          });
        }
      }

      if (tracksToPush.isEmpty) {
        throw Exception("No tracks are available to publish.");
      }

      final trackResult = await _cfService.pushTrack(
        sessionId,
        trackOffer.sdp!,
        tracksToPush,
      );
      List<String> trackIds = List<String>.from(trackResult['trackIds']);
      String trackAnswerSdp = trackResult['sdp'];

      // Apply the track push answer
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(trackAnswerSdp, 'answer'),
      );

      setState(() {
        _mySessionId = sessionId;
        _myTrackId = '$sessionId#${trackIds.join(':')}';
      });
    } catch (e, st) {
      log('$e\n$st');
      String errMsg = e.toString();
      if (errMsg.contains('NotFoundError') ||
          errMsg.contains('devices not found')) {
        errMsg =
            "Camera or microphone not found on this device.\n\n"
            "If you are using an iOS/Android Simulator, please note that physical camera hardware is not simulated. "
            "Please test on a physical device, or ensure hardware/permissions are properly configured.";
      }
      _showErrorDialog("Broadcast Error: $errMsg");
    }
  }

  /// PHASE B: PULL CO-CALLER'S STREAM USING THEIR KEY
  Future<void> _connectToRemoteUser() async {
    final remoteTrackIdInput = _remoteTrackController.text.trim();
    if (remoteTrackIdInput.isEmpty || _mySessionId == "Not Created") {
      _showErrorDialog(
        "Please start your broadcast and provide a valid target Key first.",
      );
      return;
    }

    try {
      final parts = remoteTrackIdInput.split('#');
      if (parts.length != 2) {
        _showErrorDialog("Invalid Key format. Make sure you copied the entire key.");
        return;
      }
      final publisherSessionId = parts[0];
      final trackIdsString = parts[1];

      List<String> remoteTrackIds = trackIdsString
          .split(':')
          .where((id) => id.isNotEmpty)
          .toList();
      if (remoteTrackIds.isEmpty) {
        _showErrorDialog("Invalid Key format. No tracks found in key.");
        return;
      }

      // 1. Tell Cloudflare we want to subscribe to these remote Track IDs
      final pullResult = await _cfService.pullTracks(
        _mySessionId,
        publisherSessionId,
        remoteTrackIds,
      );
      String cloudflareOfferSdp = pullResult['sdp'];

      // 2. Cloudflare sends us a pull offer, set it as Remote Description
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(cloudflareOfferSdp, 'offer'),
      );

      // 3. Generate our local answer to receive the media blocks
      RTCSessionDescription localAnswer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(localAnswer);

      // 4. Send our local answer back to conclude the negotiation
      await _cfService.renegotiateSession(_mySessionId, localAnswer.sdp!);
    } catch (e, st) {
      log('$e\n$st');
      _showErrorDialog("Connection Error: $e");
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Status Info"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _localStream?.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection?.close();
    _remoteTrackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cloudflare SFU Client-Only Call")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Media Displays
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 180,
                      color: Colors.black12,
                      child: Stack(
                        children: [
                          RTCVideoView(_localRenderer, mirror: true),
                          const Positioned(
                            top: 8,
                            left: 8,
                            child: Text(
                              "Local Cam",
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 180,
                      color: Colors.black12,
                      child: Stack(
                        children: [
                          RTCVideoView(_remoteRenderer),
                          const Positioned(
                            top: 8,
                            left: 8,
                            child: Text(
                              "Remote Peer",
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Key Management Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _startBroadcasting,
                        child: const Text("Step 1: Go Live & Generate My Key"),
                      ),
                      const Divider(),
                      const Text(
                        "Share this Key with your friend:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SelectableText(
                              _myTrackId,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 18),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: _myTrackId),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Key copied!")),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Peer Input Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _remoteTrackController,
                        decoration: const InputDecoration(
                          labelText: "Paste Friend's Key Here",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _connectToRemoteUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Step 2: Connect to Friend"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
