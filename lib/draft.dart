// void playGame(GameButton gb) {
//   setState(
//     () {
//       if (activePlayer == 1) {
//         gb.imagePath = 'Assets/Images/letterX.png';
//         gb.bgColor = Colors.green.shade100;
//         activePlayer = 2;
//         playerOne.add(gb.id);
//         dict[gb.id] = 'X';
//       } else {
//         gb.imagePath = 'Assets/Images/donut.png';
//         gb.bgColor = Colors.black;
//         activePlayer = 1;
//         playerTwo.add(gb.id);
//         dict[gb.id] = 'O';
//       }
//       gb.isEnabled = false;
//       if (!(checkWhichMarkWon('X') &&
//           checkWhichMarkWon('O') &&
//           checkDraw())) {
//         if (activePlayer == 2) {
//           autoPlay('hard');
//         }
//       } else {
//         return;
//       }
//     },
//   );
// }
