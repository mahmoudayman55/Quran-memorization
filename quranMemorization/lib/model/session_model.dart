import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';

import 'assignment_model.dart';
import 'dart:math';
import 'package:hive/hive.dart';
part 'session_model.g.dart';
@HiveType(typeId: 1)
class Session  {

  @HiveField(0)
   int id;

  @HiveField(1)
  late int rate;

  @HiveField(2)
   List<Assignment> _lastNewAssignment=[];

  @HiveField(3)
   List<Assignment> _lastRevisionAssignment=[];

  @HiveField(4)
   List<Assignment> _todayNewAssignment=[];

  @HiveField(5)
   List<Assignment> _todayRevisionAssignment=[];

  @HiveField(6)
   int _studentId=0;

  int get studentId => _studentId;

  set studentId(int value) {
    _studentId = value;
    student=Boxes.studentsBox().get(_studentId)!;
  }

  late Student _student;

  Session(this.id,this.rate);




  Student get student {

    return _student;
  }

  set student(Student value) {
    _student = value;
  }



  List<Assignment> get lastNewAssignment => _lastNewAssignment;

  List<Assignment> get todayRevisionAssignment => _todayRevisionAssignment;

  List<Assignment> get todayNewAssignment => _todayNewAssignment;

  List<Assignment> get lastRevisionAssignment => _lastRevisionAssignment;

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
