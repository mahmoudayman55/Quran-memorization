import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_memorization/core/controller/session_controller.dart';
import 'package:quran_memorization/core/enums/device_type.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:quran_memorization/ui_componants/assignment_widget.dart';
import 'package:quran_memorization/ui_componants/theme.dart';
import 'package:get/get.dart';
import 'custom_data_column.dart';

class AssignmentTable extends StatelessWidget {
  double maxHeight, maxWidth;
  late List<Assignment> assignments;
  AssignmentType assignmentType;
  SessionController _sessionController = Get.find<SessionController>();
  AssignmentTable(
      this.maxHeight, this.maxWidth, this.assignments, this.assignmentType);

  @override
  Widget build(BuildContext context) {
    return assignments.isEmpty
        ? Text(
            'لا يوجد تسميع',
            style: Theme.of(context).textTheme.headline2,
          )
        : DataTable(
            dividerThickness: 1,
            dataRowHeight: maxHeight * 0.04,
            headingRowHeight: maxHeight * 0.04,
            columnSpacing: maxWidth * 0.042,
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.lightGreen.withOpacity(0.2)),
            columns: [
              CustomDataColumn('السورة', context),
              CustomDataColumn('من الآية', context),
              CustomDataColumn('الي الآية', context),
              if (assignmentType == AssignmentType.todayNew ||
                  assignmentType == AssignmentType.todayRevision)
                CustomDataColumn('حذف', context),
            ],
            rows: List<DataRow>.generate(
                assignments.length,
                (index) => DataRow(
                        color:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          return index % 2 == 0
                              ? Colors.grey.shade50
                              : Colors.grey.shade300;
                        }),
                        cells: [
                          DataCell(Text(
                            assignments[index].surah.name,
                            style: Theme.of(context).textTheme.headline4,
                          )),
                          DataCell(Text(
                            assignments[index].fromVerse.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          )),
                          DataCell(Text(
                            assignments[index].toVerse.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          )),
                          if (assignmentType == AssignmentType.todayNew ||
                              assignmentType == AssignmentType.todayRevision)
                            DataCell(IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                assignmentType == AssignmentType.todayNew
                                    ? _sessionController
                                        .session.todayNewAssignment
                                        .remove(assignments[index])
                                    : _sessionController
                                        .session.todayRevisionAssignment
                                        .remove(assignments[index]);
                                _sessionController.update();
                              },
                            )),
                        ])));
  }
}
