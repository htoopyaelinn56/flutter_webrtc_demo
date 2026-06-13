import 'dart:convert';
import 'package:flutter_webrtc_demo/environment_variables.dart';
import 'package:http/http.dart' as http;

class CloudflareSfuService {
  // ⚠️ TESTING ONLY: app secrets are in .env
  static final String appId = EnvironmentVariables.sfuAppId;
  static final String appSecret = EnvironmentVariables.sfuApiToken;
  static final String baseUrl =
      "https://api.cloudflare.com/client/v4/apps/$appId";

  Map<String, String> get _headers => {
    "Authorization": "Bearer $appSecret",
    "Content-Type": "application/json",
  };

  /// Step 1: Initialize a WebRTC connection session with Cloudflare
  Future<Map<String, dynamic>> createSession(String sdpOffer) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/new"),
      headers: _headers,
      body: jsonEncode({"sdp": sdpOffer, "type": "offer"}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Create Session Failed: ${response.body}");
    }
    return jsonDecode(response.body); // Contains: sessionId, sdp (answer)
  }

  /// Step 2: Publish a local media track (audio/video) to an existing session
  Future<Map<String, dynamic>> pushTrack(
    String sessionId,
    String sdpOffer,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/$sessionId/tracks/new"),
      headers: _headers,
      body: jsonEncode({"sdp": sdpOffer, "type": "offer"}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Push Track Failed: ${response.body}");
    }
    return jsonDecode(response.body); // Contains: trackId, sdp (answer)
  }

  /// Step 3: Request an SDP offer from Cloudflare to pull a remote track
  Future<Map<String, dynamic>> pullTrack(
    String sessionId,
    String remoteTrackId,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sessions/$sessionId/tracks/new"),
      headers: _headers,
      body: jsonEncode({"trackId": remoteTrackId, "location": "remote"}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Pull Track Failed: ${response.body}");
    }
    return jsonDecode(response.body); // Contains: sdp (offer)
  }

  /// Step 4: Finalize track pulling by sending your answer back to Cloudflare
  Future<void> renegotiateSession(String sessionId, String sdpAnswer) async {
    final response = await http.put(
      Uri.parse("$baseUrl/sessions/$sessionId/renegotiate"),
      headers: _headers,
      body: jsonEncode({"sdp": sdpAnswer, "type": "answer"}),
    );
    if (response.statusCode != 200) {
      throw Exception("Renegotiation Failed: ${response.body}");
    }
  }
}
