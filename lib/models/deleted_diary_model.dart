import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'deleted_diary_model.g.dart';

@HiveType(typeId: 3)
class DeletedDiaryModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  Uint8List? imageUrl;

  @HiveField(3)
  List<String>? tags;

  @HiveField(4)
  String? mood;

  @HiveField(5)
  bool isStarred = false;

  @HiveField(6)
  DateTime dateTime;

  @HiveField(7)
  DateTime updated;

  DeletedDiaryModel({
    required this.title,
    required this.description,
    this.imageUrl,
    this.tags,
    this.mood,
    required this.isStarred,
    required this.dateTime,
    required this.updated,
  });
}
