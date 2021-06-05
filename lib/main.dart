import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nymble/Screens/Home/game_logic.dart';
import 'package:nymble/my_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Gotham'),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(milliseconds: 5200),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => GamePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              stops: [0.25, 0.85],
              end: Alignment.bottomLeft,
              colors: [
                MyColors.SPOTIFY_GREEN,
                MyColors.SPOTIFY_BLACK,
              ]),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Nymble',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dancingScript(
                    color: MyColors.SPOTIFY_BLACK,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Lottie.asset('Assets/Loading_Animations/cup_loading.json'),
                Spacer(),
                Lottie.asset('Assets/Loading_Animations/man_thinking.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
