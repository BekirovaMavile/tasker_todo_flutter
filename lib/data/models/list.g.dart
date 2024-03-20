// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListsAdapter extends TypeAdapter<Lists> {
  @override
  final int typeId = 1;

  @override
  Lists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    if (fields.containsKey(1) && fields[1] != null) {
      return Lists(
        name: fields[0] as String,
        color: fields[1] as int,
      )..tasks = (fields[2] as HiveList?)?.castHiveList();
    } else {
      return Lists(
        name: fields[0] as String,
        color: 1,
      )..tasks = (fields[2] as HiveList?)?.castHiveList();
    }
  }

  @override
  void write(BinaryWriter writer, Lists obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
