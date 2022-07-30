import 'package:quran_memorization/model/student_model.dart';
import 'package:hive/hive.dart';
class Boxes{
  static Box<Student> studentsBox()=>Hive.box<Student>('students');
}