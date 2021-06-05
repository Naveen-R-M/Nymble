import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nymble/API/api_calls.dart';
import 'package:nymble/Screens/Spotify/Services/get_songs_list.dart';
import 'package:nymble/Screens/Spotify/Services/play_song.dart';
import 'package:nymble/my_color.dart';

class HomeTab extends StatefulWidget {
  final newReleases;
  final myPlaylists;
  final recentlyPlayed;
  final authToken;
  HomeTab({
    this.newReleases,
    this.myPlaylists,
    this.recentlyPlayed,
    this.authToken,
  });

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: MyColors.SPOTIFY_GREEN,
      ),
      home: Scaffold(
        backgroundColor: MyColors.SPOTIFY_BLACK,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(8.0),
          child: SafeArea(
            child: ListView(
              children: [
                displayWidget(
                  ' NewReleases',
                  widget.newReleases,
                  true,
                  true,
                  1,
                ),
                displayWidget(
                  'Your Playlist',
                  widget.myPlaylists,
                  true,
                  false,
                  2,
                ),
                displayWidget(
                  'Recently Played',
                  widget.recentlyPlayed,
                  true,
                  true,
                  3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayWidget(title, item, bottomText1, bottomText2, gesture) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          ' $title',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: item.length != 0 ? 230 : 40,
          child: item.length != 0
              ? ListView.builder(
                  padding: EdgeInsets.only(
                    right: 8.0,
                  ),
                  itemCount: item.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (gesture == 1 || gesture == 3) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlaySong(
                                song: item[index],
                              ),
                            ),
                          );
                        }
                        if (gesture == 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GetSongsList(
                                songs: item[index],
                                authToken: widget.authToken,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        margin: EdgeInsets.only(right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image(
                                  image: NetworkImage(
                                    item[index]['url'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Spacer(),
                            bottomText1 == true
                                ? Expanded(
                                    child: Text(
                                      item[index]['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        height: 1.25,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.75,
                                      ),
                                    ),
                                  )
                                : Container(),
                            bottomText2 == true
                                ? Expanded(
                                    child: Text(
                                      '${item[index]['type']} - ${item[index]['artist']}',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        height: 1.5,
                                        letterSpacing: 0.75,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Text(
                  ' $title is empty',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
        ),
      ],
    );
  }
}
