import 'dart:developer';

import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';

import 'assignment_model.dart';
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
  @HiveField(7)
   DateTime dateTime;

  int get studentId => _studentId;



  late Student _student;

  Session(this.id,this.rate,this.dateTime);




  Student get student {

    return _student;
  }


  set student(Student value) {
    _student = value;
    _studentId=_student.id;
  }



  List<Assignment> get lastNewAssignment {
    final box= Boxes.sessionsBox();
    try {
      if(box.values.where((element) => element.studentId==studentId).isEmpty){
        return [];
      }
      Session session=box.values.firstWhere((element) => element.studentId==studentId);
      _lastNewAssignment=session.todayNewAssignment;
    } on Exception catch (e) {
      log(e.toString());
      _lastNewAssignment=[];
    }
    log(_lastNewAssignment.length.toString());
    return _lastNewAssignment;
  }
  List<Assignment> get todayRevisionAssignment => _todayRevisionAssignment;

  List<Assignment> get todayNewAssignment => _todayNewAssignment;

  List<Assignment> get lastRevisionAssignment {
    final box= Boxes.sessionsBox();
    try {
      if(box.values.where((element) => element.studentId==studentId).isEmpty){
        return [];
      }
      Session session=box.values.firstWhere((element) => element.studentId==studentId);
      _lastRevisionAssignment=session.todayRevisionAssignment;
    } on Exception catch (e) {
log(e.toString());
_lastRevisionAssignment=[];
    }
    log(_lastNewAssignment.length.toString());
    return _lastRevisionAssignment;
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
