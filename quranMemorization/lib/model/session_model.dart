import 'dart:developer';

import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';

import 'assignment_model.dart';
import 'package:hive/hive.dart';

part 'session_model.g.dart';

@HiveType(typeId: 1)
class Session {
  @HiveField(0)
  int id;

  @HiveField(1)
  late int rate;

  @HiveField(2)
  List<Assignment> _lastNewAssignment = [];

  @HiveField(3)
  List<Assignment> _lastRevisionAssignment = [];

  @HiveField(4)
  List<Assignment> _todayNewAssignment = [];

  @HiveField(5)
  List<Assignment> _todayRevisionAssignment = [];

  @HiveField(6)
  int _studentId = 0;
  @HiveField(7)
  DateTime dateTime;

  int get studentId => _studentId;

  late Student _student;

  Session(this.id, this.rate, this.dateTime);

  Student get student {
    var box = Boxes.studentsBox();
    _student = box.values.firstWhere((element) => element.id == studentId);
    return _student;
  }

  set student(Student value) {
    _student = value;
    _studentId = _student.id;
  }

  List<Assignment> get lastNewAssignment {
    final box = Boxes.assignmentsBox();

    _lastNewAssignment = box.values
        .where((element) =>
            element.sessionId == student.lastSessionId &&
            element.type == 'today_new')
        .toList();

    return _lastNewAssignment;
  }
  List<Assignment> get lastRevisionAssignment {
    final box = Boxes.assignmentsBox();
      _lastRevisionAssignment = box.values
          .where((element) =>
      element.sessionId == student.lastSessionId &&
          element.type == 'today_revision')
          .toList();

    return _lastRevisionAssignment;
  }
  List<Assignment> get previousRevision {
    final box = Boxes.assignmentsBox();
      _lastRevisionAssignment = box.values
          .where((element) =>
      element.sessionId == id &&
          element.type == 'today_revision')
          .toList();

    return _lastRevisionAssignment;
  }
  List<Assignment> get previousNew {
    final box = Boxes.assignmentsBox();
      _lastRevisionAssignment = box.values
          .where((element) =>
      element.sessionId == id &&
          element.type == 'today_new')
          .toList();

    return _lastRevisionAssignment;
  }


  List<Assignment> get todayRevisionAssignment {
    final box = Boxes.assignmentsBox();
    List<Assignment>assignments=box.values
        .where((element) =>
    element.sessionId == id &&
        element.type == 'today_revision')
        .toList();
    if(assignments.isEmpty){
      return _todayRevisionAssignment;
    }
    else{
      _todayRevisionAssignment= assignments;
      return _todayRevisionAssignment;

    }  }

  List<Assignment> get todayNewAssignment {

    final box = Boxes.assignmentsBox();
    List<Assignment>assignments=box.values
        .where((element) =>
    element.sessionId == id &&
        element.type == 'today_new')
        .toList();
    if(assignments.isEmpty){
      return _todayNewAssignment;
    }
    else{
      _todayNewAssignment= assignments;
      return _todayNewAssignment;

    }

  }


  set lastNewAssignment(List<Assignment> value) {
    _lastNewAssignment = value;
  }

  set todayRevisionAssignment(List<Assignment> value) {
    _todayRevisionAssignment = value;
  }

  set todayNewAssignment(List<Assignment> value) {
    _todayNewAssignment = value;
  }

  set lastRevisionAssignment(List<Assignment> value) {
    _lastRevisionAssignment = value;
  }
}
