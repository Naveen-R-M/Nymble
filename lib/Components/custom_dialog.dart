import 'package:flutter/material.dart';
import 'package:nymble/my_color.dart';

import '../my_color.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;
  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      backgroundColor: MyColors.ON_WIN_POPUP,
      title: new Text(title),
      content: new Text(content),
      actions: [
        new TextButton(
          onPressed: callback,
          child: new Text(actionText),
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        )
      ],
    );
  }
}
