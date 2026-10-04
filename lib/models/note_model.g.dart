// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckItemModelAdapter extends TypeAdapter<CheckItemModel> {
  @override
  final int typeId = 1;

  @override
  CheckItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      isDone: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 2;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      checkList: (fields[3] as List).cast<CheckItemModel>(),
      labelIds: (fields[4] as List).cast<String>(),
      type: fields[5] as NoteType,
      colorHex: fields[6] as int,
      isPinned: fields[7] as bool,
      isArchived: fields[8] as bool,
      isTrashed: fields[9] as bool,
      updatedAt: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.checkList)
      ..writeByte(4)
      ..write(obj.labelIds)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.colorHex)
      ..writeByte(7)
      ..write(obj.isPinned)
      ..writeByte(8)
      ..write(obj.isArchived)
      ..writeByte(9)
      ..write(obj.isTrashed)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final int typeId = 0;

  @override
  NoteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteType.text;
      case 1:
        return NoteType.checklist;
      default:
        return NoteType.text;
    }
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    switch (obj) {
      case NoteType.text:
        writer.writeByte(0);
        break;
      case NoteType.checklist:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
