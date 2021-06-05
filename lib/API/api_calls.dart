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

  static getMyPlaylists(authToken) async {
    var response = await http.get(
      Uri.parse(API.SPOTIFY_GET_USER_PLAYLIST),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    return response;
  }

  static getUserRecentlyPlayed(authToken) async {
    var response = await http.get(
      Uri.parse(API.SPOTIFY_GET_USER_RECENTLY_PLAYED),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    return response;
  }

  static getPlaylistWithId(playlistId, authToken) async {
    var response = await http.get(
      Uri.parse(API.SPOTIFY_GET_A_PLAYLIST + playlistId),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    print('response pl : ${response.statusCode}');
    print('items pl: ${jsonDecode(response.body)}');
    return response;
  }

  static getArtistsRecommendation(authToken) async {
    var response = await http.get(
      Uri.parse(API.SPOTIFY_GET_ARTIST_RECOMMENDATION),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );
    return response;
  }
}
