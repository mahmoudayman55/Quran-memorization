import 'package:quran_memorization/model/surah_model.dart';
import 'package:hive/hive.dart'
;
part 'assignment_model.g.dart';

@HiveType(typeId: 2)
class Assignment{

  @HiveField(0)
  late Surah surah;

  @HiveField(1)
  late int fromVerse;

  @HiveField(2)
  late int toVerse;

  Assignment(this.surah, this.fromVerse, this.toVerse);
}



