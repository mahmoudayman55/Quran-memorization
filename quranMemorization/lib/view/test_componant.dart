import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/student_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:quran_memorization/view/students_view.dart';

class TestView extends StatelessWidget {
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
      bool isMob = deviceInfo.deviceType == DeviceType.mobile;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: maxWidth,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: maxHeight * (isMob ? 0.3: 0.2),
                      crossAxisCount: isMob ? 1 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        height: maxHeight * 0.1,
                     );
                  },
                  itemCount: 5,
                ),
              )),
        ),
      );
    });
  }
}
