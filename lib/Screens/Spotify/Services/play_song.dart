import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nymble/Screens/Home/home_screen.dart';
import 'package:nymble/my_color.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaySong extends StatefulWidget {
  final song;
  PlaySong({this.song});

  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong>
    with AutomaticKeepAliveClientMixin<PlaySong> {
  bool isPlaying = false;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
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
                  widget.song['type'],
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
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: widget.song['height'].toDouble(),
                width: widget.song['width'].toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white12,
                      blurRadius: 20,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.song['url'],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: widget.song['width'].toDouble(),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.song['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.song['type']} - ${widget.song['artist']}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          IconButton(
            iconSize: 75,
            onPressed: () async {
              dynamic playerState = await SpotifySdk.getPlayerState();
              print('playerState : $playerState');
              setState(() {
                isPlaying = !isPlaying;
              });
              try {
                isPlaying == true
                    ? await SpotifySdk.play(
                        spotifyUri: widget.song['uri'],
                      )
                    : await SpotifySdk.pause();
              } catch (e) {
                print(e);
              }
            },
            icon: Icon(
              isPlaying == false
                  ? Icons.play_circle_fill_rounded
                  : Icons.pause_circle_filled_rounded,
              color: MyColors.SPOTIFY_GREEN,
              size: 75,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
