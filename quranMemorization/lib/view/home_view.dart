import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:quran_memorization/view/students_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      double screenWidth = deviceInfo.screenWidth;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        body: SafeArea(
        child: Padding(padding: EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             ToSectionWidget(maxHeight, maxWidth, Colors.cyan, 'students', StudentView(),"الطلاب"),
             Container(height: .5,width: maxWidth*0.7,color: Colors.white,),
             ToSectionWidget(maxHeight, maxWidth, Colors.cyan, 'sessions', HomeView(),"الحصص"),
            ],

          ),
        ),
      ),);
    });
  }

}