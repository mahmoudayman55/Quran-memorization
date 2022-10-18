import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/services/constants.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/custom_data_column.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';
import 'package:quran_memorization/view/sessions_view.dart';

import '../core/controller/students_controller.dart';
import '../core/functions/day_mouth_year_format.dart';
import '../ui_componants/assignment_table_widget.dart';
import '../ui_componants/search_bar.dart';
import '../ui_componants/student_widget.dart';
import '../ui_componants/theme.dart';
import 'home_view.dart';

class StudentView extends StatelessWidget {
  final StudentsController _studentController = Get.find<StudentsController>();

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
      bool isMob = deviceInfo.deviceType == DeviceType.mobile;

      return Scaffold(
        appBar: AppBar(
          title: SearchBar(
              maxHeight * 0.06,
              maxWidth * 0.9,
              15,
              15,
              _studentController.searchStudent,
              Colors.cyan,
              _studentController.searchController),
          centerTitle: true,
          leadingWidth: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<StudentsController>(builder: (controller) {
            return Column(
              children: [
                Expanded(
                  flex: 15,
                  child: _studentController.students.isEmpty
                      ? Center(
                          child: Text(
                            "لا يوجد طلاب\nيمكنك اضافة طالب جديد من الزر اسفل الشاشة",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent:
                                        maxHeight * (isMob ? 0.3 : 0.2),
                                    crossAxisCount: isMob ? 1 : 3),
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                  height: maxHeight * 0.1,
                                  child: StudentWidget(
                                    maxWidth,
                                    maxHeight,
                                    isMob,
                                    _studentController.students[index],
                                    null,
                                  ));
                            },
                            itemCount: _studentController.students.length,
                          ),
                      ),
                ),
                Expanded(
                    flex: 1,
                    child: ConfirmButton(
                      'اضافة طالب',
                      () => _studentController.addNewStudent(
                          context, maxHeight, maxWidth,"students"),
                      Colors.cyan,
                      maxWidth,
                      maxHeight * 0.02,
                      rad: 0,
                    ))
              ],
            );
          }),
        ),
      );
    });
  }
}
