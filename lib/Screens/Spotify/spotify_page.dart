import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nymble/API/api_calls.dart';
import 'package:nymble/Screens/Spotify/screens/home_tab.dart';
import 'package:nymble/Screens/Spotify/screens/search_tab.dart';
import 'package:nymble/Screens/Spotify/screens/your_library.dart';
import 'package:nymble/Screens/Spotify/spotify_template.dart';
import 'package:nymble/my_color.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPage extends StatefulWidget {
  @override
  _SpotifyPageState createState() => _SpotifyPageState();
}

class _SpotifyPageState extends State<SpotifyPage> {
  int _selectedIndex = 0;
  PageController _pageController;
  List<Map> newReleases = [];

  var authToken;

  final clientId = '89377afecbe44b12925ad8fcbf67af7d';
  final redirectUrl = 'https://github.com/';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spotifyInit();
    _pageController = PageController(initialPage: 0);
    setState(() {});
  }

  getNewReleases(authToken) async {
    var response = await APICalls.getSpotifyNewReleases(authToken);
    var items = jsonDecode(response.body)["albums"]["items"];
    for (var i = 0; i < items.length; i++) {
      var path = items[i]["images"][1];
      Map map = new Map();
      map['height'] = path["height"];
      map['width'] = path["width"];
      map['url'] = path["url"];

      map['name'] = items[i]['name'];
      map['id'] = items[i]['id'];
      map['type'] = items[i]['type'];
      map['uri'] = items[i]['uri'];
      map['artist'] = items[i]['artists'][0]['name'];

      newReleases.add(map);
    }

    print('status code : $newReleases[0]');
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
    );
  }

/* scope : 'user-read-playback-position,'
              'user-read-private, user-read-email,'
              'playlist-read-private, user-library-read,'
              'user-library-modify, user-top-read,'
              'playlist-read-collaborative, playlist-modify-public,'
              'playlist-modify-private, ugc-image-upload,'
              'user-follow-read, user-follow-modify,'
              'user-read-playback-state, user-modify-playback-state,'
              'user-read-currently-playing'    
  */
  spotifyInit() async {
    try {
      await SpotifySdk.connectToSpotifyRemote(
          clientId: clientId, redirectUrl: redirectUrl);
      authToken = await SpotifySdk.getAuthenticationToken(
          clientId: clientId,
          redirectUrl: redirectUrl,
          scope: 'user-read-playback-position,'
              'user-read-private, user-read-email,'
              'playlist-read-private, user-library-read,'
              'user-library-modify, user-top-read,'
              'playlist-read-collaborative, playlist-modify-public,'
              'playlist-modify-private, ugc-image-upload,'
              'user-follow-read, user-follow-modify,'
              'user-read-playback-state, user-modify-playback-state,'
              'user-read-currently-playing');
      await getNewReleases(authToken.toString());
      print('Auth Token : $authToken');
    } catch (e) {
      print(
        e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.SPOTIFY_BLACK,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.SPOTIFY_BLACK,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Your Library',
            icon: Icon(
              Icons.library_music_outlined,
            ),
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          height: 1.5,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          height: 1.5,
          letterSpacing: 0.5,
        ),
        currentIndex: _selectedIndex,
        onTap: _onTapped,
      ),
      body: authToken != Null
          ? PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) => setState(() {
                _selectedIndex = index;
              }),
              children: [
                HomeTab(
                  newReleases: newReleases,
                  myPlaylists: null,
                  recentlyPlayed: null,
                ),
                SearchTab(),
                LibraryTab(),
              ],
            )
          : Container(
              color: MyColors.SPOTIFY_BLACK,
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'Make sure you have Spotify installed on your device..',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
    );
  }
}
