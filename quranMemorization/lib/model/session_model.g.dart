// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 1;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      fields[0] as int,
      fields[1] as int,
      fields[7] as DateTime,
    )
      .._lastNewAssignment = (fields[2] as List).cast<Assignment>()
      .._lastRevisionAssignment = (fields[3] as List).cast<Assignment>()
      .._todayNewAssignment = (fields[4] as List).cast<Assignment>()
      .._todayRevisionAssignment = (fields[5] as List).cast<Assignment>()
      .._studentId = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rate)
      ..writeByte(2)
      ..write(obj._lastNewAssignment)
      ..writeByte(3)
      ..write(obj._lastRevisionAssignment)
      ..writeByte(4)
      ..write(obj._todayNewAssignment)
      ..writeByte(5)
      ..write(obj._todayRevisionAssignment)
      ..writeByte(6)
      ..write(obj._studentId)
      ..writeByte(7)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
