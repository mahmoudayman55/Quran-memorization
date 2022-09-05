// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentAdapter extends TypeAdapter<Assignment> {
  @override
  final int typeId = 2;

  @override
  Assignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assignment(
      fields[4] as int,
      fields[6] as String,
      fields[5] as int,
      fields[1] as int,
      fields[2] as int,
    )
      .._surah = fields[0] as Surah
      .._surahId = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Assignment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._surah)
      ..writeByte(1)
      ..write(obj.fromVerse)
      ..writeByte(2)
      ..write(obj.toVerse)
      ..writeByte(3)
      ..write(obj._surahId)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.sessionId)
      ..writeByte(6)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
