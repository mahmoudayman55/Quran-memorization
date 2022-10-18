import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:hive/hive.dart';

import '../../model/session_model.dart';
class Boxes{
  static Box<Student> studentsBox()=>Hive.box<Student>('students');
  static Box<Session> sessionsBox()=>Hive.box<Session>('sessions');
  static Box<Assignment> assignmentsBox()=>Hive.box<Assignment>('assignments');
  static Box<bool> onBoardingBox()=>Hive.box<bool>('onboarding');

}