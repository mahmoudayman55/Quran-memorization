import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double height;

  CustomTitle(this.text, this.height);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(margin: EdgeInsets.all(10),
          color: Theme.of(context).primaryColor,
          width: 3,
          height: height,
        ),
        Text(
          text,textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }
}
