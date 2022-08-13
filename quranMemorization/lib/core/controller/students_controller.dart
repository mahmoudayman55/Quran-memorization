import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/custom_snack_bar.dart';

class StudentsController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, phone;
  late int age;
late List<Student>students;
  addNewStudent() {
    if (formKey.currentState!.validate()) {
      final box = Boxes.studentsBox();
      int id = math.Random().nextInt(1000000);
      Student student= Student(age, [], name, phone)
        ..rate = 0
        ..id = id;
      try {
        box.put(
            id,
          student );
        students.add(student);
        update();
        Get.back();
        customSnackBar(name, "تم اضافة الطالب بنجاح.", true);
      } catch (e) {
customSnackBar('خطأ', e.toString(), false) ;     }
    }
  }
  getStudents(){
    final box = Boxes.studentsBox();
    students=box.values.toList();
    students.forEach((student) {log(student.name.toString());});
  }

  @override
  void onInit() {
    getStudents();

  }
}
