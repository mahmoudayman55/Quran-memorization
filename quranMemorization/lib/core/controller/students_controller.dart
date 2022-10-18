import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/assignment_model.dart';
import 'package:quran_memorization/model/student_model.dart';
import 'package:quran_memorization/ui_componants/custom_snack_bar.dart';

import '../../ui_componants/confirm_button.dart';
import '../../ui_componants/theme.dart';

class StudentsController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, phone;
  late int age;
  late List<Student> students;
  final studentsBox = Boxes.studentsBox();

  searchStudent(String keyWord) {
    students = studentsBox.values
        .where((element) =>
            element.name.contains(keyWord) ||
            element.id == int.tryParse(keyWord))
        .toList();
    update();
  }

  removeStudent(int studentId) {
    studentsBox.delete(studentId);
    final sessionsBox = Boxes.sessionsBox();
    final assignmentsBox = Boxes.assignmentsBox();
    Student student = students.firstWhere((element) => element.id == studentId);
    student.sessions().forEach((element) {
      sessionsBox.delete(element.id);
      //  print(element.id.toString());
      assignmentsBox.values.forEach((assignment) {
        if (assignment.sessionId == element.id) {
          assignmentsBox.delete(assignment.id);
          print(assignment.sessionId.toString() +
              "-----" +
              element.id.toString());
        }
      });
    });
    studentsBox.delete(studentId);
    students.removeWhere((element) => element.id == studentId);
    update();
  }

  updateStudent(Student student) {
    studentsBox.put(student.id, student);
    int i = students.indexWhere((element) => element.id == student.id);
    students[i] = student;
    Get.back();
    customSnackBar(student.name, 'تم تعديل بيانات الطالب بنجاح', true);
    update();
  }

  TextEditingController searchController = TextEditingController();
  addNewStudent(BuildContext context, double maxHeight, double maxWidth,
      String currentScreen) {
    Get.defaultDialog(
        title: "طالب جديد",
        titleStyle: Theme.of(context).textTheme.headline2,
        contentPadding: EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              height: maxHeight * 0.35,
              width: maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال اسم الطالب";
                        }
                      },
                      style: Theme.of(context).textTheme.headline4,
                      decoration: InputDecoration(
                          hintText: "اسم الطالب",
                          label: Text(
                            'اسم الطلب',
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.headline4,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        age = int.parse(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال عمر الطالب";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "العمر",
                          label: Text(
                            'العمر',
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.headline4,
                      onChanged: (value) {
                        phone = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال رقم الهاتف';
                        } else if (value.length != 11) {
                          return "رقم الهاتف غير صحيح";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "رقم هاتف ولي الامر",
                          label: Text(
                            'رقم الهاتف',
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ConfirmButton("اضافة", () {
                      if (formKey.currentState!.validate()) {
                        int id = math.Random().nextInt(1000000);
                        log(id.toString());
                        Student student = Student(age, name, phone)
                          ..rate = 0
                          ..id = id;
                        try {
                          List<Student> allStudents =
                              studentsBox.values.toList();

                          if (allStudents
                              .where((element) => element.name == student.name)
                              .isNotEmpty) {
                            customSnackBar(student.name,
                                "يوجد طالب يحمل نفس الاسم", false);

                            return;
                          } else {
                            studentsBox.put(id, student);

                            students.add(student);
                            update();
                            Get.back();
                            if (currentScreen == "sessions") {
                              Get.back();
                            }

                            customSnackBar(
                                name, "تم اضافة الطالب بنجاح.", true);
                          }
                        } catch (e) {
                          customSnackBar('خطأ', e.toString(), false);
                        }
                      }
                    }, Themes.darkBlue, maxWidth * 0.3, maxHeight * 0.03),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  getStudents() {
    final box = Boxes.studentsBox();
    students = box.values.toList();
    students.forEach((student) {
      log(student.name.toString());
    });
  }

  @override
  void onInit() {
    getStudents();
  }
}
