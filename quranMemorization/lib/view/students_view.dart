import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import 'home_view.dart';

class StudentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      double screenWidth = deviceInfo.screenWidth;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.defaultDialog(
                    content: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: "اسم الطالب"),
                      )  , TextFormField(
                        decoration: InputDecoration(hintText: "رقم الهاتف"),
                      ),
                      ElevatedButton(onPressed: (){}, child: Text('اضافة'))
                    ],
                  ),
                ))),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
            ),
          ),
        ),
      );
    });
  }
}
