import 'dart:math';
import 'package:hive/hive.dart';

class Surah{
late int _id;

late String name;

late int totalVerse;

Surah(this.name, this.totalVerse){
  _id=Random().nextInt(1000000);
}

int get id => _id;
}
