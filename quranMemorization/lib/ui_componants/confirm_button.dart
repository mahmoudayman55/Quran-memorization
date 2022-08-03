import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  String title;
  VoidCallback  onPressed;
  Color color;
  double width, height;

  ConfirmButton(
      this.title, this.onPressed, this.color, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,height: height,
      child: ElevatedButton(
        onPressed:onPressed,
        child: Text(
          title,style: Theme.of(context).textTheme.headline3
        ),
        style: ElevatedButton.styleFrom(
            primary: color, ),
      ),
    );
  }
}
