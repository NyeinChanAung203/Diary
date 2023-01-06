import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime dateOfBirth;

  @HiveField(2)
  String gender;

  @HiveField(3)
  Uint8List? pic;

  @HiveField(4)
  DateTime created;

  UserProfile({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    this.pic,
    required this.created,
  });

  String getDays() {
    final now = DateTime.now();
    int inDays = DateTime(now.year, now.month, now.day)
        .difference(DateTime(created.year, created.month, created.day))
        .inDays;
    return inDays.toString();
  }
}
