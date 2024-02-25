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
    return Lists(
      name: fields[0] as String, color: fields[0],
    );
  }

  @override
  void write(BinaryWriter writer, Lists obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
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
