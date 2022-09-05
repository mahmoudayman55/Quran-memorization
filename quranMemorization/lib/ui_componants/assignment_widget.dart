import 'dart:developer' as dev;
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/assignment_table_widget.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/quran_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/rate_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/theme.dart';

import '../core/services/constants.dart';
import 'custom_data_column.dart';

class AssignmentWidget extends StatelessWidget {
  double maxHeight, maxWidth;
  String title, emptyMessage;
  final AssignmentType assignmentType;

  List<Assignment> getAssignmentList(SessionController controller) {
    List<Assignment> assignments = [];
    switch (assignmentType) {
      case AssignmentType.todayRevision:
        assignments = controller.session.todayRevisionAssignment;
        break;
      case AssignmentType.todayNew:
        assignments = controller.session.todayNewAssignment;
        break;
      case AssignmentType.lastRevision:
        assignments = controller.session.lastRevisionAssignment;
        break;
      case AssignmentType.lastNew:
        assignments = controller.session.lastNewAssignment;
        break;
    }
    return assignments;
  }

  AssignmentWidget(
    this.maxHeight,
    this.maxWidth,
    this.title,
    this.emptyMessage,
    this.assignmentType,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset.fromDirection(15))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GetBuilder<SessionController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black),
            ),
            (assignmentType == AssignmentType.todayNew ||
                    assignmentType == AssignmentType.todayRevision)
                ? Column(
                    children: [
                      SizedBox(
                        width: maxWidth,
                        height: maxHeight * 0.15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'سورة',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    QuraanDropDownButton(
                                        maxWidth * 0.25,
                                        maxHeight * 0.05,
                                        controller.assignmentToAdd.surah.id,
                                        '', (v) {
                                      controller.assignmentToAdd.surahId =
                                          Surah.fromJson(Quran.quran
                                                  .where((element) =>
                                                      element['id'] == v)
                                                  .toList()[0])
                                              .id;
                                      controller.update();
                                    }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'من',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    NumericDropDownButton(
                                        maxWidth * 0.15,
                                        maxHeight * 0.05,
                                        controller.assignmentToAdd.fromVerse,
                                        '',
                                        null, (v) {
                                      controller.assignmentToAdd.fromVerse = v;
                                      controller.update();
                                    },
                                        controller
                                            .assignmentToAdd.surah.totalVerse),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الي',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    NumericDropDownButton(
                                        maxWidth * 0.15,
                                        maxHeight * 0.05,
                                        controller.assignmentToAdd.toVerse,
                                        '',
                                        null, (v) {
                                      controller.assignmentToAdd.toVerse = v;
                                      controller.update();
                                    },
                                        controller
                                            .assignmentToAdd.surah.totalVerse),
                                  ],
                                ),
                              ],
                            ),
                            ConfirmButton('اضافة السورة', () {
                              switch (assignmentType) {
                                case AssignmentType.todayRevision:
                                  controller.session.todayRevisionAssignment
                                      .add(controller.assignmentToAdd
                                        ..sessionId = controller.sessionId
                                        ..type = 'today_revision');
                                  break;
                                case AssignmentType.todayNew:
                                  controller.session.todayNewAssignment
                                      .add(controller.assignmentToAdd
                                        ..sessionId = controller.sessionId
                                        ..type = 'today_new');
                                  break;
                                default:
                                  dev.log(
                                      'only todayNew and todayRevision are able to edit');
                              }
                              controller.assignmentToAdd =
                                  Assignment(0, 'type', 0, 1, 6);

                              controller.update();
                            }, Themes.softBlue, maxWidth * 0.3,
                                maxHeight * 0.045)
                          ],
                        ),
                      ),
                      Container(
                        color: Themes.darkBlue,
                        height: 1,
                        width: maxWidth * 0.7,
                      ),
                      SizedBox(
                        width: maxWidth,
                        height: maxHeight * 0.15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'من سورة: ',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    QuraanDropDownButton(
                                        maxWidth * 0.25,
                                        maxHeight * 0.05,
                                        controller.fromSurah.surahId,
                                        '', (v) {
                                      controller.fromSurah.surahId = v;
                                      dev.log(v.toString());
                                      dev.log(
                                          "selected surah: ${controller.fromSurah.surah}");

                                      controller.update();
                                    }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الي سورة: ',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    QuraanDropDownButton(
                                        maxWidth * 0.25,
                                        maxHeight * 0.05,
                                        controller.toSurah.surah.id,
                                        '', (v) {
                                      controller.toSurah.surah = Surah.fromJson(
                                          Quran.quran
                                              .where((element) =>
                                                  element['id'] == v)
                                              .toList()[0]);
                                      controller.update();
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            ConfirmButton('اضافة السور', () {
                              List<Surah> surahsToAdd = Quran.quran
                                  .where((element) =>
                                      element['id'] >=
                                          controller.fromSurah.surah.id &&
                                      element['id'] <=
                                          controller.toSurah.surah.id)
                                  .map((e) => Surah.fromJson(e))
                                  .toList();
                              switch (assignmentType) {
                                case AssignmentType.todayRevision:
                                  surahsToAdd.forEach((element) {
                                    controller.session.todayRevisionAssignment
                                        .add(Assignment(
                                            Random().nextInt(1000000),
                                            'today_revision',
                                            controller.sessionId,
                                            1,
                                            element.totalVerse)..surahId=element.id
                                    );
                                  });
                                  break;
                                case AssignmentType.todayNew:
                                  surahsToAdd.forEach((element) {
                                    controller.session.todayNewAssignment
                                        .add(Assignment(
                                        Random().nextInt(1000000),
                                        'today_new',
                                        controller.sessionId,
                                        1,
                                        element.totalVerse)..surahId=element.id
                                    );
                                  });
                                  break;
                                default:
                                  dev.log(
                                      'only todayNew and todayRevision are able to edit');
                              }

                              controller.update();
                            }, Themes.softBlue, maxWidth * 0.3,
                                maxHeight * 0.045)
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            getAssignmentList(controller).isEmpty
                ? Text(
                    emptyMessage,
                    style: Theme.of(context).textTheme.headline1,
                  )
                : AssignmentTable(
                    maxHeight, maxWidth, getAssignmentList(controller)),
          ],
        );
      }),
    );
  }
}
