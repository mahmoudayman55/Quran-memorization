import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  Color buttonColor;
  Color textColor = const Color.fromARGB(255, 251, 238, 274);
  double width, height;
  double rad;
  ConfirmButton(
      this.title, this.onPressed, this.buttonColor, this.width, this.height,
      {this.rad = 10});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: buttonColor)),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(1),
          shadowColor: buttonColor.withOpacity(0.1),
          elevation: 0,
          fixedSize: Size(width, height),
          primary: Color.fromRGBO(
              buttonColor.red, buttonColor.green, buttonColor.blue, .08)),
    );
  }
}
