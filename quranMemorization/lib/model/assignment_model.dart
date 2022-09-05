import 'package:quran_memorization/core/services/quran.dart';
import 'package:quran_memorization/model/surah_model.dart';
import 'package:hive/hive.dart'
;
part 'assignment_model.g.dart';

@HiveType(typeId: 2)
class Assignment{

  @HiveField(0)
  late Surah _surah;

  @HiveField(1)
  late int fromVerse;

  @HiveField(2)
  late int toVerse;



  set surah(Surah value) {
    _surah = value;
  }

  @HiveField(3)
  late int _surahId;

  Surah get surah => _surah;

  set surahId(int value) {
    surah=Surah.fromJson(Quran.quran.firstWhere((element) => element['id']==value));

    _surahId = value;
  }

  @HiveField(4)
  late int id;
  @HiveField(5)
  late int sessionId;
  @HiveField(6)
  late String type;

  Assignment(this.id,this.type,this.sessionId, this.fromVerse, this.toVerse){
   surahId=1;
  }

  int get surahId => _surahId;
}



