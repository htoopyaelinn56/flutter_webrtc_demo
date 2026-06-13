import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter_webrtc_demo/environment_variables.dart';
import 'package:http/http.dart' as http;

class CloudflareSfuService {
  // ⚠️ TESTING ONLY: app secrets are in .env
  static final String appId = EnvironmentVariables.sfuAppId;
  static final String appSecret = EnvironmentVariables.sfuApiToken;
  static final String baseUrl =
      "https://rtc.live.cloudflare.com/v1/apps/$appId";

  Map<String, String> get _headers => {
    "Authorization": "Bearer $appSecret",
    "Content-Type": "application/json",
  };

  /// Step 1: Initialize a WebRTC connection session with Cloudflare
  Future<Map<String, dynamic>> createSession(String sdpOffer) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/new"),
      headers: _headers,
      body: jsonEncode({
        "sessionDescription": {"sdp": sdpOffer, "type": "offer"},
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Create Session Failed: ${response.body}");
    }
    final data = jsonDecode(response.body);
    return {
      'sessionId': data['sessionId'],
      'sdp': data['sessionDescription']['sdp'],
    };
  }

  /// Step 2: Publish local media tracks (audio/video) to an existing session
  Future<Map<String, dynamic>> pushTrack(
    String sessionId,
    String sdpOffer,
    List<Map<String, dynamic>> tracks,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/$sessionId/tracks/new"),
      headers: _headers,
      body: jsonEncode({
        "sessionDescription": {"sdp": sdpOffer, "type": "offer"},
        "tracks": tracks,
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Push Track Failed: ${response.body}");
    }
    final data = jsonDecode(response.body);
    final returnedTracks = data['tracks'] as List;
    log('Returned Tracks: $returnedTracks');
    final trackIds = returnedTracks
        .map((t) => t['trackName'] ?? t['trackId'] as String)
        .toList();
    return {'trackIds': trackIds, 'sdp': data['sessionDescription']['sdp']};
  }

  /// Step 3: Request an SDP offer from Cloudflare to pull remote tracks
  Future<Map<String, dynamic>> pullTracks(
    String sessionId,
    String publisherSessionId,
    List<String> remoteTrackIds,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/$sessionId/tracks/new"),
      headers: _headers,
      body: jsonEncode({
        "tracks": remoteTrackIds
            .map((id) => {
                  "trackName": id,
                  "sessionId": publisherSessionId,
                  "location": "remote"
                })
            .toList(),
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Pull Track Failed: ${response.body}");
    }
    final data = jsonDecode(response.body);
    return {'sdp': data['sessionDescription']['sdp']};
  }

  /// Step 4: Finalize track pulling by sending your answer back to Cloudflare
  Future<void> renegotiateSession(String sessionId, String sdpAnswer) async {
    final response = await http.put(
      Uri.parse("$baseUrl/sessions/$sessionId/renegotiate"),
      headers: _headers,
      body: jsonEncode({
        "sessionDescription": {"sdp": sdpAnswer, "type": "answer"},
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Renegotiation Failed: ${response.body}");
    }
  }
}
