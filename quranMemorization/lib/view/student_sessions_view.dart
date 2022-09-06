import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/functions/day_mouth_year_format.dart';
import 'package:quran_memorization/ui_componants/assignment_table_widget.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/custom_data_column.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/rate_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import '../core/controller/students_controller.dart';
import '../ui_componants/theme.dart';
import 'home_view.dart';

class StudentSessionsView extends StatelessWidget {
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: GetBuilder<SessionController>(builder: (c) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(width: maxWidth,
                  child: DataTable(
                      dividerThickness: 1,
                      dataRowHeight: maxHeight * 0.08,
                      headingRowHeight: maxHeight * 0.04,
                      columnSpacing: maxWidth * 0.042,
                      headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Themes.darkBlue),
                      columns: [
                        CustomDataColumn('الاسم', context),
                        CustomDataColumn('التسميع', context),
                        CustomDataColumn('التقييم', context),
                        CustomDataColumn('الحصة\nالفادمة', context),
                        CustomDataColumn('التاريخ', context),
                      ],
                      rows: List<DataRow>.generate(
                          _sessionController.sessions.length,
                              (index) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                    return index % 2 == 0
                                        ? Colors.grey.shade50
                                        : Colors.grey.shade300;
                                  }),
                              cells: [
                                DataCell(Text(
                                  _sessionController
                                      .sessions[index].student.name,
                                  style:
                                  Theme.of(context).textTheme.headline4,
                                )),
                                DataCell(IconButton(
                                  icon: const Icon(
                                    Icons.web,
                                    color: Colors.lightGreen,
                                  ),
                                  onPressed: () => Get.defaultDialog(
                                      content: index != 0
                                          ? Column(
                                        children: [
                                          Text(
                                            "المراجعة",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          AssignmentTable(
                                              maxHeight,
                                              maxWidth,
                                              _sessionController
                                                  .sessions[index - 1]
                                                  .previousRevision),
                                          Text(
                                            "الجديد",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          AssignmentTable(
                                              maxHeight,
                                              maxWidth,
                                              _sessionController
                                                  .sessions[index - 1]
                                                  .previousNew),
                                        ],
                                      )
                                          : Text(
                                        'لا يوجد تسميع',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      )),
                                )),
                                DataCell(Text(
                                  _sessionController.sessions[index].rate
                                      .toString(),
                                  style:
                                  Theme.of(context).textTheme.headline4,
                                )),
                                DataCell(IconButton(
                                  onPressed: () => Get.defaultDialog(
                                      content:Column(
                                        children: [
                                          Text(
                                            "المراجعة",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          AssignmentTable(
                                              maxHeight,
                                              maxWidth,
                                              _sessionController
                                                  .sessions[index]
                                                  .todayRevisionAssignment),
                                          Text(
                                            "الجديد",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          ),
                                          AssignmentTable(
                                              maxHeight,
                                              maxWidth,
                                              _sessionController
                                                  .sessions[index]
                                                  .todayNewAssignment),
                                        ],
                                      )
                                  ),
                                  icon: Icon(
                                    Icons.archive,
                                    color: Colors.lightGreen,
                                  ),
                                )),
                                DataCell(Text(
                                  getDMYFormat(_sessionController
                                      .sessions[index].dateTime),
                                  style:
                                  Theme.of(context).textTheme.headline4,
                                )),
                              ]))),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
