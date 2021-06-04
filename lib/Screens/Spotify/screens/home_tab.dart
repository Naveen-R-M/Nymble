import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Welcome to Home Tab',
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
