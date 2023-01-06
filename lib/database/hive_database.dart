import 'dart:typed_data';

import 'package:diary/models/deleted_diary_model.dart';
import 'package:diary/models/diary_model.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/models/user_profile_model.dart';
import 'package:diary/utils/constants.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper {
  DbHelper._();

  static DbHelper? _instance;

  static DbHelper instance() {
    return _instance ??= DbHelper._();
  }

  final Box<DiaryModel> _diariesBox = Hive.box<DiaryModel>('diaries');

  Box<DiaryModel> get diariesBox => _diariesBox;

  List<DiaryModel> allDiaries() =>
      diariesBox.values.toList().cast<DiaryModel>();

  Future<void> createDiary(DiaryModel diaryModel) async {
    await diariesBox.add(diaryModel);
  }

  setStarred(DiaryModel diaryModel) {
    diaryModel.isStarred = !diaryModel.isStarred;
    diaryModel.save();
  }

  updateDiary(
      DiaryModel diaryModel,
      String? title,
      String? description,
      Uint8List? imageUrl,
      List<String>? tags,
      String? mood,
      bool? isStarred,
      DateTime? dateTime,
      DateTime? updated) {
    diaryModel.title = title ?? diaryModel.title;
    diaryModel.description = description ?? diaryModel.description;
    diaryModel.imageUrl = imageUrl ?? diaryModel.imageUrl;
    diaryModel.tags = tags ?? diaryModel.tags;
    diaryModel.mood = mood ?? diaryModel.mood;
    diaryModel.isStarred = isStarred ?? diaryModel.isStarred;
    diaryModel.dateTime = dateTime ?? diaryModel.dateTime;
    diaryModel.updated = updated ?? diaryModel.updated;

    // print(diaryModel);
    // print('isEdited from provider');
    // print('Title ${diaryModel.title}');
    // print('Description ${diaryModel.description}');
    // print('Tags ${diaryModel.tags}');
    // print('ImageUrL ${diaryModel.imageUrl}');
    // print('Mood ${diaryModel.mood}');
    // print('Starred ${diaryModel.isStarred}');
    // print('DateTime ${diaryModel.dateTime}');
    diaryModel.save();
  }

  deleteDiary(DiaryModel diaryModel) {
    diaryModel.delete();
  }

  /// ********************************************** */
  /* For user profile */

  final Box<UserProfile> _userBox = Hive.box<UserProfile>('userProfile');
  Box<UserProfile> get userBox => _userBox;

  Future createUserProfile(UserProfile userProfile) async {
    await _userBox.clear();
    // print('userbox length : ${_userBox.length}');
    await _userBox.add(userProfile);
  }

  UserProfile? getUserProfile() {
    try {
      final user = _userBox.values.toList().cast<UserProfile>().last;
      // print('getuserprofile $user');
      return user;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  updateUserProfile(
    UserProfile userProfile,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    Uint8List? pic,
  ) {
    userProfile.name = name ?? userProfile.name;
    userProfile.dateOfBirth = dateOfBirth ?? userProfile.dateOfBirth;
    userProfile.gender = gender ?? userProfile.gender;
    userProfile.pic = pic ?? userProfile.pic;

    userProfile.save();
  }

  deleteUserProfile(UserProfile userProfile) {
    userProfile.delete();
  }

  /// ******************************************** */

  final Box<PasswordModel> _passwordBox = Hive.box<PasswordModel>('security');
  Box<PasswordModel> get passwordBox => _passwordBox;

  Future createPassword(PasswordModel passwordModel) async {
    // _passwordBox.values.map((e) => print(e.password));
    await _passwordBox.clear();

    // print('passwordbox length: ${_passwordBox.length}');
    await _passwordBox.add(passwordModel);
  }

  Future createQuestion(Map<String, String> question) async {
    var password = getPasswordModel();
    if (password != null) {
      password.question = question;
      password.save();
    }
  }

  PasswordModel? getPasswordModel() {
    try {
      return _passwordBox.values.toList().cast<PasswordModel>().last;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  updatePassword(
    PasswordModel passwordModel,
    String? password,
    Map<String, String>? question,
  ) {
    passwordModel.password = password ?? passwordModel.password;
    passwordModel.question = question ?? passwordModel.question;
    passwordModel.save();
  }

  deletePassword(PasswordModel passwordModel) {
    passwordModel.delete();
  }

  toggleLockApp(PasswordModel passwordModel) {
    passwordModel.islock = !passwordModel.islock;
    passwordModel.save();
  }

  /// *************************************************************** */
  /* Deleted Diaries */
  final Box<DeletedDiaryModel> _deletedDiariesBox =
      Hive.box<DeletedDiaryModel>('deleted_diaries');

  Box<DeletedDiaryModel> get deletedDiariesBox => _deletedDiariesBox;

  List<DeletedDiaryModel> allDeletedDiaries() =>
      _deletedDiariesBox.values.toList().cast<DeletedDiaryModel>();

  Future<void> createDeletedDiary(DeletedDiaryModel deletedDiaryModel) async {
    await _deletedDiariesBox.add(deletedDiaryModel);
  }

  deleteDeletedDiary(DeletedDiaryModel deletedDiaryModel) {
    deletedDiaryModel.delete();
  }

  // setStarred(DiaryModel diaryModel) {
  //   diaryModel.isStarred = !diaryModel.isStarred;
  //   diaryModel.save();
  // }

  // updateDiary(
  //     DiaryModel diaryModel,
  //     String? title,
  //     String? description,
  //     Uint8List? imageUrl,
  //     List<String>? tags,
  //     String? mood,
  //     bool? isStarred,
  //     DateTime? dateTime,
  //     DateTime? updated) {
  //   diaryModel.title = title ?? diaryModel.title;
  //   diaryModel.description = description ?? diaryModel.description;
  //   diaryModel.imageUrl = imageUrl ?? diaryModel.imageUrl;
  //   diaryModel.tags = tags ?? diaryModel.tags;
  //   diaryModel.mood = mood ?? diaryModel.mood;
  //   diaryModel.isStarred = isStarred ?? diaryModel.isStarred;
  //   diaryModel.dateTime = dateTime ?? diaryModel.dateTime;
  //   diaryModel.updated = updated ?? diaryModel.updated;

  //   // print(diaryModel);
  //   // print('isEdited from provider');
  //   // print('Title ${diaryModel.title}');
  //   // print('Description ${diaryModel.description}');
  //   // print('Tags ${diaryModel.tags}');
  //   // print('ImageUrL ${diaryModel.imageUrl}');
  //   // print('Mood ${diaryModel.mood}');
  //   // print('Starred ${diaryModel.isStarred}');
  //   // print('DateTime ${diaryModel.dateTime}');
  //   diaryModel.save();
  // }

  int joyfulMood = 0;
  int happyMood = 0;
  int normalMood = 0;
  int angryMood = 0;
  int sadMood = 0;
  int noMood = 0;

  void countMoods() {
    joyfulMood = 0;
    happyMood = 0;
    normalMood = 0;
    angryMood = 0;
    sadMood = 0;
    noMood = 0;
    allDiaries().forEach((element) {
      switch (element.mood) {
        case joyfulEmoji:
          joyfulMood++;
          break;
        case happyEmoji:
          happyMood++;
          break;
        case normalEmoji:
          normalMood++;
          break;
        case sadEmoji:
          sadMood++;
          break;
        case angryEmoji:
          angryMood++;
          break;
        default:
          noMood++;
          break;
      }
    });
  }
}
