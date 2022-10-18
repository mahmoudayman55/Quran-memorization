import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quran_memorization/model/session_model.dart';

import '../core/services/hive_boxes.dart';

part 'student_model.g.dart';

//flutter pub run build_runner build

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late int _id;

  @HiveField(1)
  double _rate = 0;

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

  Student(this.age, this.name, this.parentPhoneNumber,
      {Key? key, this.lastSessionId = 0});

  int get id => _id;

  //eval getter
  String get evaluation {
    // print("total rate= ${_rate}");
    if (_rate >= 0 && _rate < 50) {
      _evaluation = "مقبول";
    } else if (_rate >= 50 && _rate < 60) {
      _evaluation = "جيد";
    } else if (_rate >= 60 && _rate < 80) {
      _evaluation = "جيد جدا";
    } else if (_rate >= 80 && _rate <= 100) {
      _evaluation = "ممتاز";
    }
    return _evaluation;
  }

//rate getter
  double get rate => _rate;

  set id(int value) {
    _id = value;
  } //rate setter

  set rate(double value) {
    if (value == 0) {
      _rate = 0;
      _evaluation = "مقبول";
      return;
    }
    double sum = value;

    sessions().forEach((element) {
      sum = sum + element.rate ;
    });
    _rate = (sum / (sessions().isEmpty?1:sessions().length+1 )) * 10;
    print("total rate= ${_rate}");
  }

  int getStudentAttendance() {
    final box = Boxes.sessionsBox();
    return box.values.where((session) => session.studentId == id).length;
  }

  Session? previousSession(int currentSessionId) {
    List<Session> previousSessions = sessions();
    for (int i = 0; i < previousSessions.length; i++) {
      if (previousSessions[i].id == currentSessionId) {
        return i == 0 ? null : previousSessions[i - 1];
      }
    }
    return null;
  }

  List<Session> sessions() {
    try {
      var box = Boxes.sessionsBox();
      if (box.values.where((element) => element.studentId == _id).isEmpty) {
        return [];
      }
      List<Session> sessions =
          box.values.where((element) => element.studentId == _id).toList();
      sessions.sort(
        (a, b) => a.dateTime.compareTo(b.dateTime),
      );
      return sessions;
    } on Exception catch (e) {
      return [];
    }
  }
}
