import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nymble/Components/custom_dialog.dart';
import 'package:nymble/Screens/Home/game_button.dart';

import '../../my_color.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<GameButton> buttonsList;
  String human = 'Assets/Images/letterX.png';
  String bot = 'Assets/Images/donut.png';

  var dict = {
    0: ' ',
    1: ' ',
    2: ' ',
    3: ' ',
    4: ' ',
    5: ' ',
    6: ' ',
    7: ' ',
    8: ' ',
  };

  var playerOne;
  var playerTwo;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = buttonInit();
  }

  List<GameButton> buttonInit() {
    playerOne = [];
    playerTwo = [];
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(
      () {
        if (activePlayer == 1) {
          gb.imagePath = 'Assets/Images/letterX.png';
          gb.bgColor = Colors.green.shade100;
          activePlayer = 2;
          playerOne.add(gb.id);
          dict[gb.id] = 'O';
        } else {
          gb.imagePath = 'Assets/Images/donut.png';
          gb.bgColor = Colors.black;
          activePlayer = 1;
          playerTwo.add(gb.id);
          dict[gb.id] = 'X';
        }
        gb.isEnabled = false;
        if (activePlayer == 2) {
          autoPlay('hard');
        }
      },
    );
  }

  void autoPlay(String x) {
    if (x == 'easy') {
      print('easy');
      var emptyGrids = [];
      var list = new List.generate(9, (index) => index + 1);
      for (var gridId in list) {
        if (!(playerOne.contains(gridId) || (playerTwo.contains(gridId)))) {
          emptyGrids.add(gridId);
        }
      }
      var random = new Random();
      var randIndex = random.nextInt(emptyGrids.length - 1);
      var gridId = emptyGrids[randIndex];
      int i = buttonsList.indexWhere((element) => element.id == gridId);
      playGame(buttonsList[i]);
    } else {
      print('hard');
      var bestScore = -8000;
      var bestMove = 0;
      var score;
      for (var keys in dict.keys) {
        if (dict[keys] == ' ') {
          dict[keys] = 'O';
          score = miniMax(dict, 0, false);
          print('score for ${dict[keys]} is $score');
          dict[keys] = ' ';
          if (score > bestScore) {
            bestScore = score;
            bestMove = keys;
          }
        }
      }
      playGame(buttonsList[bestMove]);
      return;
    }
  }

  miniMax(buttonsList, depth, isMaximizing) {
    var bestScore;
    var score;

    if (checkWhichMarkWon('O')) {
      showDialog(
        context: context,
        builder: (builder) => new CustomDialog(
          'Match Won by Bot',
          'Press the reset button to start again',
          resetGame,
        ),
      );
      return 1;
    } else if (checkWhichMarkWon('X')) {
      showDialog(
        context: context,
        builder: (builder) => new CustomDialog(
          'Match Won by you',
          'Press the reset button to start again',
          resetGame,
        ),
      );
      return -1;
    } else if (checkDraw()) {
      showDialog(
        context: context,
        builder: (builder) => new CustomDialog(
          'Match Draw',
          'Press the reset button to start again',
          resetGame,
        ),
      );
      return 0;
    }

    if (isMaximizing) {
      bestScore = -800;
      for (var keys in dict.keys) {
        if (dict[keys] == ' ') {
          dict[keys] = 'O';
          score = miniMax(dict, depth + 1, false);
          dict[keys] = ' ';
          if (score > bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    } else {
      bestScore = 800;
      for (var keys in dict.keys) {
        if (dict[keys] == ' ') {
          dict[keys] = 'X';
          score = miniMax(dict, depth + 1, true);
          dict[keys] = ' ';
          if (score < bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    }
  }

  checkDraw() {
    for (var keys in dict.keys) {
      if (dict[keys] == ' ') return false;
    }
    return true;
  }

  checkWhichMarkWon(mark) {
    if (dict[0] == dict[1] && dict[0] == dict[2] && dict[0] == mark)
      return true;
    else if (dict[3] == dict[4] && dict[3] == dict[5] && dict[3] == mark)
      return true;
    else if (dict[6] == dict[7] && dict[6] == dict[8] && dict[6] == mark)
      return true;
    else if (dict[0] == dict[3] && dict[0] == dict[6] && dict[0] == mark)
      return true;
    else if (dict[1] == dict[4] && dict[1] == dict[7] && dict[1] == mark)
      return true;
    else if (dict[2] == dict[5] && dict[2] == dict[8] && dict[2] == mark)
      return true;
    else if (dict[0] == dict[4] && dict[0] == dict[8] && dict[0] == mark)
      return true;
    else if (dict[6] == dict[4] && dict[6] == dict[2] && dict[6] == mark)
      return true;
    else
      return false;
  }

  void resetGame() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    setState(() {
      buttonsList = buttonInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'Assets/Images/game_bck_green_1.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 9.0,
                    crossAxisSpacing: 9.0,
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, index) => new SizedBox(
                    height: 100,
                    width: 100,
                    child: new ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: buttonsList[index].bgColor,
                        padding: const EdgeInsets.all(8.0),
                      ),
                      onPressed: buttonsList[index].isEnabled
                          ? () => playGame(buttonsList[index])
                          : null,
                      child: buttonsList[index].imagePath != ""
                          ? Image(
                              image: AssetImage(
                                buttonsList[index].imagePath,
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Material(
                            color: MyColors.ON_WIN_POPUP,
                            elevation: 10.0,
                            child: InkWell(
                              onTap: () => resetGame(),
                              splashColor: Colors.black26,
                              child: SizedBox(
                                height: 75,
                                width: 75,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(
                                    image: AssetImage(
                                      'Assets/Images/refresh_leaves.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Reset',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.brown.shade700,
                            height: 1.5,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Material(
                            color: MyColors.ON_WIN_POPUP,
                            elevation: 10.0,
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.black26,
                              child: SizedBox(
                                height: 75,
                                width: 75,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Image(
                                    image: AssetImage(
                                      'Assets/Images/question_mark_leaves.png',
                                    ),
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Help',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.brown.shade700,
                            height: 1.5,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
