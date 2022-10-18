import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/functions/day_mouth_year_format.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:quran_memorization/view/students_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui_componants/assignment_table_widget.dart';

class SessionWidget extends StatelessWidget {
  Color get evalColor {
    Color color = Colors.red;
    switch (session.student.evaluation) {
      case "جيد ":
        color = Colors.deepOrange;
        break;
      case "جيد جدا":
        color = Colors.amber;
        break;
      case "ممتاز":
        color = Colors.lightGreen;
        break;
    }
    return color;
  }

  Color get rateColor {
    Color color = Colors.red;
    int rate = session.rate;
    if (rate >= 0 && rate < 3) {
      color = Colors.red;
    } else if (rate >= 3 && rate < 5) {
      color = Colors.orange;
    } else if (rate >= 5 && rate < 7) {
      color = Colors.amber;
    } else if (rate >= 7 && rate <= 10) {
      color = Colors.lightGreen;
    }
    return color;
  }

  double maxWidth, maxHeight;
  Session session;
  SessionWidget(this.maxHeight, this.maxWidth, this.session);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: maxWidth * 0.95,
          height: maxHeight * 0.18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset.fromDirection(1.5, 3),
                    spreadRadius: 3,
                    blurRadius: 6)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    session.student.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'tajawal'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "التقييم العام\n${session.student.evaluation}",
                        style: TextStyle(
                            color: evalColor,
                            fontSize: 18.sp,
                            fontFamily: 'tajawal'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConfirmButton(
                      'تسميع الحصه',
                      () => Get.defaultDialog(
                              content: SizedBox(
                            height: maxHeight * 0.7,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "المراجعة",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  AssignmentTable(
                                      maxHeight,
                                      maxWidth,
                                      session.student.previousSession(
                                                  session.id) ==
                                              null
                                          ? []
                                          : session.student
                                              .previousSession(session.id)!
                                              .todayRevisionAssignment,
                                      AssignmentType.lastRevision),
                                  Text(
                                    "الجديد",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  AssignmentTable(
                                      maxHeight,
                                      maxWidth,
                                      session.student.previousSession(
                                                  session.id) ==
                                              null
                                          ? []
                                          : session.student
                                              .previousSession(session.id)!
                                              .todayNewAssignment,
                                      AssignmentType.lastNew),
                                ],
                              ),
                            ),
                          )),
                      Color.fromARGB(255, 208, 135, 181),
                      maxWidth * 0.31,
                      maxHeight * 0.05),
                  Text(
                    getDMYFormat(session.dateTime),
                    style: TextStyle(
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontSize: 18.sp,
                        fontFamily: 'tajawal'),
                  ),
                  ConfirmButton(
                      'الحصه القادمة',
                      () => Get.defaultDialog(
                              content: SizedBox(
                            height: maxHeight * 0.7,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "المراجعة",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  AssignmentTable(
                                      maxHeight,
                                      maxWidth,
                                      session.todayRevisionAssignment,
                                      AssignmentType.lastRevision),
                                  Text(
                                    "الجديد",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  AssignmentTable(
                                      maxHeight,
                                      maxWidth,
                                      session.todayNewAssignment,
                                      AssignmentType.lastNew),
                                ],
                              ),
                            ),
                          )),
                      Color.fromARGB(255, 38, 86, 183),
                      maxWidth * 0.31,
                      maxHeight * 0.05),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -maxHeight * 0.06,
          child: Container(
            alignment: Alignment.center,
            width: maxWidth * 0.25,
            height: maxWidth * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset.fromDirection(1.5, 3),
                      spreadRadius: 3,
                      blurRadius: 6)
                ]),
            child: Text(
              "${session.rate}/10",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: rateColor),
            ),
          ),
        ),
      ],
    );
  }
}
