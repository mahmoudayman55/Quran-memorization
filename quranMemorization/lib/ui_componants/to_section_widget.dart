import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ToSectionWidget extends StatelessWidget {
  late double maxHeight, maxWidth;
  late Color color;
  late String image, title;
  late String screen;

  ToSectionWidget(this.maxHeight, this.maxWidth, this.color, this.image,
      this.screen, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('$screen'),
      child: Container(
        height: maxHeight * 0.44,
        alignment: Alignment.center,
        width: maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          //  border: Border.all(color: color,width: 2)
        ),
        child: Column(
          children: [
            Image.asset('assets/images/$image.png', height: maxHeight * 0.36),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 18.sp))
          ],
        ),
      ),
    );
  }
}
