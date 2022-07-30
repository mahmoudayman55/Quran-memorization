// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fields[2] as int,
      (fields[3] as List).cast<DateTime>(),
      fields[4] as String,
      fields[5] as String,
    )
      .._id = fields[0] as int
      .._rate = fields[1] as int
      .._evaluation = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._rate)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.attendedDays)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.parentPhoneNumber)
      ..writeByte(6)
      ..write(obj._evaluation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
