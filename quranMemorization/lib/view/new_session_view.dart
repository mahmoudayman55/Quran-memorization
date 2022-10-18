import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/functions/day_mouth_year_format.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/assignment_widget.dart';
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.indigo.withOpacity(0.3),
          elevation: 0,
          centerTitle: true,
          title: Text(_sessionController.session.student.name,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.indigo, fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: GetBuilder<SessionController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 12,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomTitle('الحضور:', maxHeight * 0.04),
                                  Text(
                                    '${_sessionController.session.student.getStudentAttendance()} حصص',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(color: Colors.black54),
                                  )
                                ],
                              ),
                            ],
                          ),
                          CustomTitle('التسميع', maxHeight * 0.04),
                          AssignmentWidget(
                            maxHeight,
                            maxWidth,
                            'المراجعة',
                            'لا يوجد مراجعة',
                            AssignmentType.lastRevision,
                          ),
                          AssignmentWidget(maxHeight, maxWidth, 'الجديد',
                              'لا يوجد تسميع جديد', AssignmentType.lastNew),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child:
                                      CustomTitle('التقييم', maxHeight * 0.04)),
                              Expanded(
                                flex: 1,
                                child: NumericDropDownButton(
                                    maxWidth * 0.2,
                                    maxHeight * 0.04,
                                    _sessionController.session.rate,
                                    'التقييم',
                                    null, (value) {
                                  _sessionController.session.rate = value;
                                  _sessionController.update();
                                }, 10),
                              ),
                              // CustomTitle(
                              //     'التقييم العام\n${_sessionController.session.student
                              //         .evaluation}', maxHeight * 0.04),
                            ],
                          ),
                          CustomTitle('الحصه القادمة', maxHeight * 0.04),
                          AssignmentWidget(
                              maxHeight,
                              maxWidth,
                              'المراجعة',
                              'لا يوجد تسميع جديد',
                              AssignmentType.todayRevision),
                          AssignmentWidget(maxHeight, maxWidth, 'الجديد',
                              'لا يوجد تسميع جديد', AssignmentType.todayNew),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ConfirmButton(
                      'انهاء الحصه',
                      _sessionController.endSession,
                      Colors.indigo,
                      maxWidth,
                      maxHeight * 0.06),
                )
              ],
            );
          }),
        ),
      );
    });
  }
}
