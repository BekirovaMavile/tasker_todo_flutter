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
        color: Color(fields[1] as int),
      );
    } else {
      return Lists(
        name: fields[0] as String,
        color: Colors.white,
      );
    }
  }

  @override
  void write(BinaryWriter writer, Lists obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1);

    if (obj.color != null) {
      writer.write(obj.color!.value);
    } else {
      writer.write(null);
    }
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
