import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:quran_memorization/view/students_view.dart';
import 'package:quran_memorization/view/test_componant.dart';
import 'package:get/get.dart';

import '../../ui_componants/on_boarding_message.dart';

class IntroScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      double screenWidth = deviceInfo.screenWidth;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: maxWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlue.shade500, Colors.indigo],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          padding: EdgeInsets.all(10),
          child: OnBoardingMessage(
              maxHeight, maxWidth, "m", "مرحبا بك في تطبيق المحفظ"),
        ),
      );
    });
  }
}
