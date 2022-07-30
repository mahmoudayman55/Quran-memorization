import 'package:quran_memorization/model/student_model.dart';

import 'assignment_model.dart';
import 'dart:math';
import 'package:hive/hive.dart';
part 'session_model.g.dart';
@HiveType(typeId: 1)
class Session extends HiveObject{

  @HiveField(0)
  late int _id;

  @HiveField(1)
  late int rate;

  @HiveField(2)
  late List<Assignment> _lastNewAssignment;

  @HiveField(3)
  late List<Assignment> _lastRevisionAssignment;

  @HiveField(4)
  late List<Assignment> _todayNewAssignment;

  @HiveField(5)
  late List<Assignment> _todayRevisionAssignment;

  @HiveField(6)
  late Student student;

  Session(this.rate,this.student);

  int get id => _id;

  set id(int value) {
    _id = value;
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
