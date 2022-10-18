import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingMessage extends StatelessWidget {
  late double maxHeight, maxWidth;
  late String image, title;

  OnBoardingMessage(this.maxHeight, this.maxWidth, this.image, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      alignment: Alignment.center,
      width: maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        //  border: Border.all(color: color,width: 2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/$image.png', height: maxHeight * 0.36),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white, fontSize: 22.sp),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
