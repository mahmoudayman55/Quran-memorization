import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:quran_memorization/view/home_view.dart';
import 'package:quran_memorization/view/onboarding/intro_screen1.dart';
import 'package:quran_memorization/view/onboarding/intro_screen2.dart';
import 'package:quran_memorization/view/onboarding/intro_screen3.dart';
import 'package:quran_memorization/view/onboarding/intro_screen4.dart';
import 'package:quran_memorization/view/students_view.dart';
import 'package:quran_memorization/view/test_componant.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/services/hive_boxes.dart';

class OnBoardingView extends StatefulWidget {
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _controller = PageController();

  int currentPage = 0;

  Color get getActiveColor {
    Color activeColor = Colors.indigo;
    switch (currentPage) {
      case 0:
        activeColor = Colors.indigo;
        break;
      case 1:
        activeColor = Colors.purple;
        break;
      case 2:
        activeColor = Colors.deepOrange;
        break;
      case 3:
        activeColor = Colors.blueGrey;
        break;
    }
    return activeColor;
  }

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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue.shade500, Colors.indigo],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Stack(children: [
          Container(
            height: maxHeight,
            child: PageView(
              onPageChanged: (value) => setState(() {
                currentPage = value;
              }),
              controller: _controller,
              children: [
                IntroScreen1(),
                IntroScreen2(),
                IntroScreen3(),
                IntroScreen4(),
              ],
            ),
          ),
          Container(
              alignment: Alignment(0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        _controller.jumpToPage(3);
                      },
                      child: Text(
                        'تخطي',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      )),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      dotColor: Colors.white,
                      activeDotColor: getActiveColor,
                    ),
                  ),
                  TextButton(
                      onPressed: currentPage == 3
                          ? () {
                              Boxes.onBoardingBox().put(1, true);
                              Get.offAll(HomeView());
                            }
                          : () {
                              _controller.nextPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInOut);
                            },
                      child: Text(
                        currentPage == 3 ? "متابعة" : 'التالي',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      )),
                ],
              )),
        ]),
      ));
    });
  }
}
