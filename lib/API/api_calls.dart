import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nymble/API/api.dart';

class APICalls {
  static getSpotifyNewReleases(authToken) async {
    var response = await http.get(
      Uri.parse(API.SPOTIFY_ALBUM_NEW_RELEASES),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    dynamic result = jsonDecode(response.body);
    print('result : $result');
    return response;
  }
}
