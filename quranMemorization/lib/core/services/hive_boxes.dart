import 'package:quran_memorization/model/student_model.dart';
import 'package:hive/hive.dart';

import '../../model/session_model.dart';
class Boxes{
  static Box<Student> studentsBox()=>Hive.box<Student>('students');
  static Box<Session> sessionsBox()=>Hive.box<Session>('sessions');
}