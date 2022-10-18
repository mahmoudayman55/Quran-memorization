import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quran_memorization/core/controller/students_controller.dart';
import 'package:quran_memorization/core/functions/day_mouth_year_format.dart';
import 'package:quran_memorization/core/services/constants.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/session_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/confirm_button.dart';
import 'package:quran_memorization/view/sessions_view.dart';

import '../../model/surah_model.dart';
import '../../ui_componants/custom_data_column.dart';
import '../../ui_componants/custom_snack_bar.dart';
import '../../ui_componants/student_widget.dart';
import '../../ui_componants/theme.dart';

class SessionController extends GetxController {
  int sessionId = Random().nextInt(1000000);

  late Session session;
  List<Session> sessions = [];

  Assignment assignmentToAdd = Assignment(0, 'type', 0, 1, 1,1);
  Assignment fromSurah = Assignment(Random().nextInt(1000000), 'type', 0, 1, 1,1);
  Assignment toSurah = Assignment(Random().nextInt(1000000), 'type', 0, 1, 1,1);
  TextEditingController searchController = TextEditingController();
  endSession() {
    final sessionsBox = Boxes.sessionsBox();
    final studentsBox = Boxes.studentsBox();
    final assignmentsBox = Boxes.assignmentsBox();
    session.id = sessionId;
    studentsBox.put(
        session.studentId,
        session.student
          ..lastSessionId = session.id
          ..rate = session.rate.toDouble());
    session.todayNewAssignment.forEach((element) {
    });

    assignmentsBox
        .addAll(session.todayNewAssignment+session.todayRevisionAssignment);
    sessionsBox.put(session.id, session);

    
    sessions.add(session);
    Get.back();
    update();

    customSnackBar('تم الحفظ بنجاح',
        "${session.student.name} --- ${getDMYFormat(session.dateTime)}", true);
    session.lastRevisionAssignment.clear();
    session.lastNewAssignment.clear();
    session.todayRevisionAssignment.clear();
    session.todayNewAssignment.clear();
    sessionId = Random().nextInt(1000000);
  }
  @override
  void onInit() {
    getSessions();
  }

  searchSessions(String keyWord) {
    final sessionsBox = Boxes.sessionsBox();
    sessions = sessionsBox.values
        .where((element) =>
            element.student.name.contains(keyWord) ||
            element.student.id == int.tryParse(keyWord))
        .toList();
    update();
  }

  getSessions() {
    var box = Boxes.sessionsBox();
    sessions = box.values.toList();
    sessions.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  startSession(
      BuildContext context, double maxWidth, double maxHeight, bool isMob) {
    StudentsController _studentsController = Get.find<StudentsController>();
    Get.defaultDialog(
        content: _studentsController.students.isEmpty
            ? SizedBox(
                height: maxHeight * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "لا يوجد طلاب",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ConfirmButton("اضافة طالب", () {
                        _studentsController.addNewStudent(
                            context, maxHeight, maxWidth, "sessions");
                      }, Colors.red, maxWidth * 0.3, maxHeight * 0.03),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: maxHeight * 0.8,
                width: maxWidth,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: maxHeight * (isMob ? 0.3 : 0.2),
                      crossAxisCount: isMob ? 1 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        height: maxHeight * 0.1,
                        child: StudentWidget(
                          maxWidth,
                          maxHeight,
                          isMob,
                          _studentsController.students[index],
                          () {
                            session = Session(
                                Random().nextInt(100000), 1, DateTime.now())
                              ..student = _studentsController.students[index];
                            Get.offNamed('/new_session');
                          },
                        ));
                  },
                  itemCount: _studentsController.students.length,
                ),
              ));
  }
}
