/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui_componants/custom_data_column.dart';

class ss extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: maxWidth,
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
                                                            .sessions[index].student.previousSession(_sessionController.sessions[index].id)==null?[]: _sessionController
                                                            .sessions[index].student.previousSession(_sessionController.sessions[index].id)!.todayRevisionAssignment),
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
                                                            .sessions[index].student.previousSession(_sessionController.sessions[index].id)==null?[]: _sessionController
                                                            .sessions[index].student.previousSession(_sessionController.sessions[index].id)!.todayNewAssignment),
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
                                      onPressed: 
                                      () => Get.defaultDialog(
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
              );  }

}







SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
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
                        //  CustomDataColumn('التقييم', context),
                        CustomDataColumn('الحضور', context),
                      ],
                      rows: List<DataRow>.generate(
                          _studentController.students.length,
                          (index) => DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                    return index % 2 == 0
                                        ? Colors.grey.shade50
                                        : Colors.grey.shade300;
                                  }),
                                  cells: [
                                    DataCell(Text(
                                      _studentController.students[index].name,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )),
                                    DataCell(Text(
                                      _studentController
                                          .students[index].parentPhoneNumber,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )),
                               
                                    DataCell(IconButton(
                                      onPressed: () {
                                        final SessionController
                                            _sessionController =
                                            Get.find<SessionController>();
                                        _sessionController.searchController
                                            .text = _studentController.students[index].name;
                                        _sessionController.searchSessions(
                                            _studentController
                                                .students[index].id.toString());
                                        Get.to(SessionsView());
                                      },
                                      icon: Icon(
                                        Icons.archive,
                                        color: Colors.lightGreen,
                                      ),
                                    )),
                                  ]))),
                ),
              ) 

*/


