import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/ui_componants/custom_data_column.dart';
import 'package:quran_memorization/ui_componants/device_info_widget.dart';
import 'package:quran_memorization/ui_componants/rate_drop_down_button.dart';
import 'package:quran_memorization/ui_componants/to_section_widget.dart';
import 'package:get/get.dart';

import '../core/controller/students_controller.dart';
import '../ui_componants/theme.dart';
import 'home_view.dart';

class SessionsView extends StatelessWidget {
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: Themes.darkBlue,
            child: Icon(Icons.add),
            onPressed: () =>_sessionController.startSession(context, maxWidth, maxHeight)),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: GetBuilder<SessionController>(builder: (controller) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                      CustomDataColumn('الحصه القادمة', context),
                      CustomDataColumn('التاريخ', context),
                    ],
                    rows: List<DataRow>.generate(
                     _sessionController.sessions.length   ,
                        (index) => DataRow(
                                color: MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  return index % 2 == 0
                                      ? Colors.grey.shade50
                                      : Colors.grey.shade300;
                                }),
                                cells: [
                                  DataCell(Text(
                                   _sessionController.sessions[index].student.name,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  )),
                                  DataCell(Icon(Icons.web_rounded)),
                                  DataCell(
NumericDropDownButton(maxWidth*0.2,maxHeight*0.05,_sessionController.sessions[index].rate,'rate',null,(value){
  _sessionController.sessions[index].rate=value;
  _sessionController.update();
  log(_sessionController.sessions[index].rate.toString());



},10)                                  ),
                                  DataCell(Text(
                                    '_studentController.students[index].evaluation',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  )),
                                  DataCell(IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.archive,
                                      color: Colors.lightGreen,
                                    ),
                                  )),
                                ]))),
              );
            }),
          ),
        ),
      );
    });
  }
}
