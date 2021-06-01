import 'package:flutter/material.dart';
import 'package:nymble/my_color.dart';

class GameButton {
  final id;
  String imagePath;
  Color bgColor;
  bool isEnabled;
  GameButton({
    this.id,
    this.imagePath = "",
    this.bgColor = MyColors.GRID_BCK,
    this.isEnabled = true,
  });
}
