import 'package:hive/hive.dart';

part 'password_model.g.dart';

@HiveType(typeId: 2)
class PasswordModel extends HiveObject {
  @HiveField(0)
  String? password;

  @HiveField(1)
  Map<String, String>? question;

  @HiveField(2)
  bool islock;

  PasswordModel({this.password, this.question, required this.islock});
}
