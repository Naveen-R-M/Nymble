import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Welcome to Search Tab',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
