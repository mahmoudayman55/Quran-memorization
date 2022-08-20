import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';

import '../../model/surah_model.dart';
import '../../ui_componants/custom_data_column.dart';
import '../../ui_componants/custom_snack_bar.dart';
import '../../ui_componants/theme.dart';

class SessionController extends GetxController{
  late Session session;

  List<Session>sessions=[];

    Assignment assignmentToAdd=Assignment(Surah(1,"الفاتحة",7),1,6);
  Assignment fromSurah=Assignment(Surah(1,"الفاتحة",7),1,6);
  Assignment toSurah=Assignment(Surah(1,"الفاتحة",7),1,6);

  @override
  void onInit() {
    getSessions();
  }

  getSessions(){
    var box=Boxes.sessionsBox();
    sessions=box.values.toList();
  }
startSession(BuildContext context,double maxWidth,double maxHeight){
  StudentsController _studentsController=Get.find<StudentsController>();

  Get.defaultDialog(content: SingleChildScrollView(
    child: SizedBox(height: maxHeight*0.7,
      width: maxWidth,
      child: DataTable(
          dividerThickness: 1,
          dataRowHeight: maxHeight * 0.04,
          headingRowHeight: maxHeight * 0.04,
          columnSpacing: maxWidth * 0.042,
          headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Themes.darkBlue),

          columns: [
            CustomDataColumn('الاسم', context),
            CustomDataColumn('الهاتف', context),
            CustomDataColumn('التقييم', context),
            CustomDataColumn('ارشيف', context),

          ],
          rows: List<DataRow>.generate(
              _studentsController.students.length,
                  (index) => DataRow(onSelectChanged: (st){
                  session= Session(Random().nextInt(100000), 1,DateTime.now())..student=_studentsController.students[index];
                  Get.toNamed('/new_session');
                  },
                  color: MaterialStateProperty.resolveWith<Color>(

                          (states) {
                        return index % 2 == 0
                            ? Colors.grey.shade50
                            : Colors.grey.shade300;
                      }),
                  cells: [
                    DataCell(Text(
                      _studentsController.students[index].name,style: Theme.of(context).textTheme.headline4,
                    )),
                    DataCell(Text(
                      _studentsController.students[index].parentPhoneNumber,style: Theme.of(context).textTheme.headline4,
                    )),
                    DataCell(Text(
                      _studentsController.students[index].evaluation,style: Theme.of(context).textTheme.headline4,
                    )),
                    DataCell(
                        IconButton(onPressed: (){},icon: Icon(Icons.archive,color:Colors.lightGreen,),)                                ),
                  ]))),
    ),
  ));
}
}