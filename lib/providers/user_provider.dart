import 'dart:typed_data';

import 'package:diary/database/hive_database.dart';
import 'package:diary/models/user_profile_model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class UserProvider extends ChangeNotifier {
  final DbHelper _dbHelper = DbHelper.instance();

  String? getUserName() {
    return userProfile?.name;
  }

  UserProfile? get userProfile => _dbHelper.getUserProfile();

  void updateUserProfile(
      String name, String dateTime, String gender, Uint8List? pic) {
    userProfile!.name = name;
    userProfile!.dateOfBirth = DateFormat.yMd().parse(dateTime);
    userProfile!.gender = gender;
    userProfile!.pic = pic;
    userProfile!.save();
    notifyListeners();
  }
}
