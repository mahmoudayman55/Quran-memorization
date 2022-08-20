import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/assignment_table.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/custom_data_column.dart';
import 'package:quran_memorization/ui_componants/custom_title.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/rate_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import '../core/controller/students_controller.dart';
import '../ui_componants/theme.dart';
import 'home_view.dart';

class NewSessionView extends StatelessWidget {
  final SessionController _sessionController = Get.find<SessionController>();

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double maxWidth = deviceInfo.width;
      double maxHeight = deviceInfo.height;
      double screenWidth = deviceInfo.screenWidth;
      double screenHeight = deviceInfo.screenHeight;

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              '${_sessionController.session.dateTime.day}-${_sessionController
                  .session.dateTime.month}-${_sessionController.session.dateTime
                  .year}'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: GetBuilder<SessionController>(builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(_sessionController.session.student.name,
                            maxHeight * 0.04),
                        Text(
                          _sessionController.session.student.parentPhoneNumber,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black54),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomTitle('الحضور:', maxHeight * 0.04),
                            Text(
                              '${_sessionController.session.student
                                  .getStudentAttendance()} حصص',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.black54),
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'تفاصيل',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline1,
                            ))
                      ],
                    ),
                    CustomTitle('التسميع', maxHeight * 0.04),
                    AssignmentTable(
                        maxHeight,
                        maxWidth,
                        'المراجعة',
                        'لا يوجد مراجعة',AssignmentType.lastRevision
                        ),
                    AssignmentTable(
                        maxHeight,
                        maxWidth,
                        'الجديد',
                        'لا يوجد تسميع جديد',AssignmentType.lastNew
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle('التقييم', maxHeight * 0.04),
                        NumericDropDownButton(
                            maxWidth * 0.2,
                            maxHeight * 0.04,
                            _sessionController.session.rate,
                            'التقييم',
                            null,
                                (value) {
                              _sessionController.session.rate = value;
                            },
                            10),
                        CustomTitle(
                            'التقييم العام\n${_sessionController.session.student
                                .evaluation}', maxHeight * 0.04),

                      ],
                    ),

                    CustomTitle('الحصه القادمة', maxHeight * 0.04),

                    AssignmentTable(
                        maxHeight,
                        maxWidth,
                        'المراجعة',
                        'لا يوجد تسميع جديد',AssignmentType.todayRevision
                    ),   AssignmentTable(
                        maxHeight,
                        maxWidth,
                        'الجديد',
                        'لا يوجد تسميع جديد',AssignmentType.todayNew
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
