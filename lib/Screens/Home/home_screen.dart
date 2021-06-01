import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nymble/Components/custom_dialog.dart';
import 'package:nymble/Screens/Home/game_button.dart';

import '../../my_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  String human = 'Assets/Images/letterX.png';
  String bot = 'Assets/Images/donut.png';

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
        } else {
          gb.imagePath = 'Assets/Images/donut.png';
          gb.bgColor = Colors.black;
          activePlayer = 1;
          playerTwo.add(gb.id);
        }
        gb.isEnabled = false;
        int winner = checkWinner();
        if (winner == -1) {
          if (buttonsList.every((element) => element.imagePath != '')) {
            showDialog(
              context: context,
              builder: (builder) => new CustomDialog(
                'Match Draw',
                'Press the reset button to start again',
                resetGame,
              ),
            );
          } else {
            activePlayer == 2 ? autoPlay('hard') : null;
          }
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
      var bestMove;
      var score;
      for (var grid in buttonsList) {
        if (grid.imagePath == '') {
          grid.imagePath = bot;
          score = miniMax(buttonsList, 0, false);
          print('score for ${grid.id} is $score');
          grid.imagePath = '';
          if (score > bestScore) {
            bestScore = score;
            bestMove = grid;
          }
        }
      }
      playGame(bestMove);
      return;
    }
  }

  miniMax(buttonsList, depth, isMaximizing) {
    var bestScore;
    var score;
    var winner = checkWinner();
    if (winner == 2) {
      return 1;
    } else if (winner == 1) {
      return -1;
    } else if (buttonsList.every((element) => element.imagePath != "")) {
      return 0;
    }

    if (isMaximizing) {
      bestScore = -800;
      for (var grid in buttonsList) {
        if (grid.imagePath == '') {
          grid.imagePath = bot;
          score = miniMax(buttonsList, depth + 1, false);
          grid.imagePath = '';
          if (score > bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    } else {
      bestScore = 800;
      for (var grid in buttonsList) {
        if (grid.imagePath == '') {
          grid.imagePath = human;
          score = miniMax(buttonsList, depth + 1, true);
          grid.imagePath = '';
          if (score < bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    }
  }

  int checkWinner() {
    var winner = -1;
    if (playerOne.contains(1) &&
        playerOne.contains(2) &&
        playerOne.contains(3)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(2) &&
        playerTwo.contains(3)) {
      winner = 2;
    }

    // row 2
    if (playerOne.contains(4) &&
        playerOne.contains(5) &&
        playerOne.contains(6)) {
      winner = 1;
    }
    if (playerTwo.contains(4) &&
        playerTwo.contains(5) &&
        playerTwo.contains(6)) {
      winner = 2;
    }

    // row 3
    if (playerOne.contains(7) &&
        playerOne.contains(8) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(7) &&
        playerTwo.contains(8) &&
        playerTwo.contains(9)) {
      winner = 2;
    }

    // col 1
    if (playerOne.contains(1) &&
        playerOne.contains(4) &&
        playerOne.contains(7)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(4) &&
        playerTwo.contains(7)) {
      winner = 2;
    }

    // col 2
    if (playerOne.contains(2) &&
        playerOne.contains(5) &&
        playerOne.contains(8)) {
      winner = 1;
    }
    if (playerTwo.contains(2) &&
        playerTwo.contains(5) &&
        playerTwo.contains(8)) {
      winner = 2;
    }

    // col 3
    if (playerOne.contains(3) &&
        playerOne.contains(6) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(3) &&
        playerTwo.contains(6) &&
        playerTwo.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (playerOne.contains(1) &&
        playerOne.contains(5) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(5) &&
        playerTwo.contains(9)) {
      winner = 2;
    }

    if (playerOne.contains(3) &&
        playerOne.contains(5) &&
        playerOne.contains(7)) {
      winner = 1;
    }
    if (playerTwo.contains(3) &&
        playerTwo.contains(5) &&
        playerTwo.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 1 Won",
                "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 2 Won",
                "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
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
