import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {

  @HiveField(0)
late int _id;

@HiveField(1)
late int _rate;

@HiveField(2)
late int age;

@HiveField(3)
late List<DateTime> attendedDays;

@HiveField(4)
late String name;

@HiveField(5)
late String parentPhoneNumber;

@HiveField(6)
late String _evaluation;

  Student( this.age, this.attendedDays, this.name, this.parentPhoneNumber,{Key? key});

  int get id => _id;

  //eval getter
String get evaluation => _evaluation;

//rate getter
int get rate => _rate;

//rate setter
  set rate(int value) {
    _rate = value;

    //set eval according to rate
    if(rate>=0&&rate<=3){
      _evaluation="مقبول";
    }
    else  if(rate>=4&&rate<=6){
      _evaluation="جيد";
    }
    else  if(rate==7&&rate==8){
      _evaluation="جيد جدا";
    }
    else  if(rate==9&&rate==10){
      _evaluation="ممتاز";
    }
  }



}