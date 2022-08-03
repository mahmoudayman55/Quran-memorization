import 'dart:developer';
import 'dart:math'as math;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quran_memorization/core/services/hive_boxes.dart';
import 'package:quran_memorization/model/student_model.dart';
class StudentsController extends GetxController{
   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   late String name,phone;
   late int age;
  addNewStudent(){
    if(formKey.currentState!.validate()){
      final box=Boxes.studentsBox();
    int id=math.Random().nextInt(1000000);
    try {
      box.put(id, Student(age, [], name, phone)..rate=0..id=id );
    }
    catch (e) {
      log(e.toString());
    }
    }


  }
}