import 'dart:math';
import 'package:hive/hive.dart';
part 'surah_model.g.dart';

@HiveType(typeId: 3)
class Surah{

@HiveField(0)
late int id;

@HiveField(1)
late String name;

@HiveField(2)
late int totalVerse;

Surah(this.id,this.name, this.totalVerse);

}
