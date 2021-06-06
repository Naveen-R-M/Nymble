import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            child: Center(
              child: Text(
                'Welcome to Search Tab',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
