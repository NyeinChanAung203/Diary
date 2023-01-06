// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_diary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeletedDiaryModelAdapter extends TypeAdapter<DeletedDiaryModel> {
  @override
  final int typeId = 3;

  @override
  DeletedDiaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeletedDiaryModel(
      title: fields[0] as String,
      description: fields[1] as String,
      imageUrl: fields[2] as Uint8List?,
      tags: (fields[3] as List?)?.cast<String>(),
      mood: fields[4] as String?,
      isStarred: fields[5] as bool,
      dateTime: fields[6] as DateTime,
      updated: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeletedDiaryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.mood)
      ..writeByte(5)
      ..write(obj.isStarred)
      ..writeByte(6)
      ..write(obj.dateTime)
      ..writeByte(7)
      ..write(obj.updated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeletedDiaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
