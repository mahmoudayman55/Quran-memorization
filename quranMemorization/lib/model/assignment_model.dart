import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:hive/hive.dart';
part 'assignment_model.g.dart';

@HiveType(typeId: 2)
class Assignment {
  @HiveField(0)
  late int fromVerse;

  @HiveField(1)
  late int toVerse;

  @HiveField(2)
  late int surahId;

  @HiveField(3)
  late int id;
  @HiveField(4)
  late int sessionId;

  @HiveField(5)
  late String type;

  late Surah _surah;

  Surah get surah {
    _surah = Surah.fromJson(
        Quran.quran.firstWhere((element) => element['id'] == surahId));
    return _surah;
  }



  Assignment(this.id, this.type, this.sessionId, this.fromVerse, this.toVerse,this.surahId);
}
