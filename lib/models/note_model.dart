import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
enum NoteType {
  @HiveField(0)
  text,
  @HiveField(1)
  checklist,
}

@HiveType(typeId: 1)
class CheckItemModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isDone;

  CheckItemModel({
    required this.id,
    required this.title,
    this.isDone = false,
  });
}

@HiveType(typeId: 2)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  List<CheckItemModel> checkList;

  @HiveField(4)
  List<String> labelIds;

  @HiveField(5)
  NoteType type;

  @HiveField(6)
  int colorHex;

  @HiveField(7)
  bool isPinned;

  @HiveField(8)
  bool isArchived;

  @HiveField(9)
  bool isTrashed;

  @HiveField(10)
  DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    this.content = '',
    this.checkList = const [],
    this.labelIds = const [],
    this.type = NoteType.text,
    this.colorHex = 0xFFFFFFFF,
    this.isPinned = false,
    this.isArchived = false,
    this.isTrashed = false,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();
}