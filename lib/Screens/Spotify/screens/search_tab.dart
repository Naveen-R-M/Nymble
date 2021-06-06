import 'package:flutter/material.dart';
import 'package:nymble/my_color.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool isfolded = true;
  int textLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(
              left: 20,
            ),
            duration: Duration(milliseconds: 300),
            width: isfolded ? 56 : width - 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
              boxShadow: kElevationToShadow[6],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.0,
                    ),
                    child: !isfolded
                        ? TextField(
                            onChanged: (val) {
                              textLength = val.length;
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search tracks, artist, albums',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColors.SPOTIFY_GREEN,
                                letterSpacing: 1.5,
                              ),
                              border: InputBorder.none,
                            ),
                          )
                        : null,
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Row(
                    children: [
                      textLength > 0
                          ? Material(
                              type: MaterialType.transparency,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  isfolded ? 32 : 0,
                                ),
                                topRight: Radius.circular(
                                  32,
                                ),
                                bottomLeft: Radius.circular(
                                  isfolded ? 32 : 0,
                                ),
                                bottomRight: Radius.circular(
                                  32,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isfolded = !isfolded;
                                  });
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: MyColors.SPOTIFY_GREEN,
                                ),
                              ),
                            )
                          : SizedBox(),
                      Material(
                        type: MaterialType.transparency,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            isfolded ? 32 : 0,
                          ),
                          topRight: Radius.circular(
                            32,
                          ),
                          bottomLeft: Radius.circular(
                            isfolded ? 32 : 0,
                          ),
                          bottomRight: Radius.circular(
                            32,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isfolded = !isfolded;
                              textLength = 0;
                            });
                          },
                          child: Icon(
                            isfolded
                                ? Icons.search_rounded
                                : Icons.close_rounded,
                            color: MyColors.SPOTIFY_GREEN,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              'Welcome to Search Tab',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
