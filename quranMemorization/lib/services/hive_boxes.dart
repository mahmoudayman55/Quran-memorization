import 'package:quran_memorization/models/student_model.dart';
import 'package:hive/hive.dart';
class Boxes{
  static Box<Student> studentsBox()=>Hive.box<Student>('students');
}