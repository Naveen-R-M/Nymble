import 'package:flutter/material.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Welcome to Library Tab',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
