import 'package:flutter/material.dart';
import 'package:nymble/Screens/Spotify/Services/play_song.dart';
import 'package:nymble/my_color.dart';

class HomeTab extends StatefulWidget {
  final newReleases;
  final myPlaylists;
  final recentlyPlayed;
  HomeTab({this.newReleases, this.myPlaylists, this.recentlyPlayed});

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
      home: Scaffold(
        backgroundColor: MyColors.SPOTIFY_BLACK,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  ' New Releases',
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
                  height: 230,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      right: 8.0,
                    ),
                    itemCount: widget.newReleases.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => PlaySong(
                                song: widget.newReleases[index],
                              ),
                            ),
                          );
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
                                      widget.newReleases[index]['url'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  widget.newReleases[index]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.25,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.75,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.newReleases[index]['type']} - ${widget.newReleases[index]['artist']}',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    height: 1.5,
                                    letterSpacing: 0.75,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
