import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'student_model.g.dart';

//flutter pub run build_runner build

@HiveType(typeId: 0)
class Student extends HiveObject {
@HiveField(0)
late int _id;

@HiveField(1)
 int? _rate;

@HiveField(2)
 int age;

@HiveField(3)
int lastSessionId;

@HiveField(4)
 String name;

@HiveField(5)
 String parentPhoneNumber;

@HiveField(6)
late String _evaluation;

  Student( this.age, this.name, this.parentPhoneNumber,{Key? key,this.lastSessionId =0});

  int get id => _id;

  //eval getter
String get evaluation => _evaluation;

//rate getter
int? get rate => _rate;

  set id(int value) {
    _id = value;
  } //rate setter
  set rate(int? value) {
    _rate = value;

    //set eval according to rate
    if(rate!>=0&&rate!<=3){
      _evaluation="مقبول";
    }
    else  if(rate!>=4&&rate!<=6){
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