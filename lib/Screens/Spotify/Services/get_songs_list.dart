import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nymble/API/api_calls.dart';
import 'package:nymble/Screens/Spotify/Services/play_song.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class GetSongsList extends StatefulWidget {
  final songs;
  final authToken;
  GetSongsList({this.songs, this.authToken});
  @override
  _GetSongsListState createState() => _GetSongsListState();
}

class _GetSongsListState extends State<GetSongsList>
    with AutomaticKeepAliveClientMixin<GetSongsList> {
  @override
  bool get wantKeepAlive => true;
  List<Map> playlistSongsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlaylistSongs();
  }

  getPlaylistSongs() async {
    var response = await APICalls.getPlaylistWithId(
      widget.songs['id'],
      widget.authToken,
    );
    var items = jsonDecode(response.body)['tracks']['items'];

    for (var i = 0; i < items.length; i++) {
      var path = items[i];

      Map map = new Map();
      map['id'] = path['track']['id'];
      map['name'] = path['track']['name'];
      map['uri'] = path['track']['uri'];
      map['type'] = path['track']['type'];
      map['artist'] = path['track']['artists'][0]['name'];
      map['url'] = path['track']['album']['images'][1]['url'];
      map['height'] = path['track']['album']['images'][1]['height'];
      map['width'] = path['track']['album']['images'][1]['width'];

      playlistSongsList.add(map);
      print('map : $map');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                ' ${widget.songs['name']}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: playlistSongsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlaySong(
                      song: playlistSongsList[index],
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(
                  8.0,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        height: 65,
                        width: 65,
                        image: NetworkImage(
                          playlistSongsList[index]['url'],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${playlistSongsList[index]['name']}',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                              height: 1.5),
                        ),
                        Text(
                          '${playlistSongsList[index]['type']} - ${playlistSongsList[index]['artist']}',
                          style: TextStyle(
                            color: Colors.white54,
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
