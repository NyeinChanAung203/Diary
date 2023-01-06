import 'dart:typed_data';

import 'package:diary/database/hive_database.dart';
import 'package:diary/models/diary_model.dart';
import 'package:flutter/widgets.dart';

class DiaryProvider extends ChangeNotifier {
  DiaryProvider() {
    _seperateDiary();
  }

  final DbHelper _dbHelper = DbHelper.instance();

  bool _isStarred = false;

  final _now = DateTime.now();
  final List<DiaryModel> _todayList = [];
  final List<DiaryModel> _yesterdayList = [];
  final List<DiaryModel> _recentlyList = [];

  List<DiaryModel> get todayList => _todayList;
  List<DiaryModel> get yesterdayList => _yesterdayList;
  List<DiaryModel> get recentlyList => _recentlyList;

  bool isEmptyDiaries() {
    final diaries = _dbHelper.allDiaries();
    if (diaries.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _seperateDiary() {
    final diaries = _dbHelper.allDiaries();
    _todayList.clear();
    _yesterdayList.clear();
    _recentlyList.clear();
    for (var e in diaries) {
      var num = DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day)
          .difference(DateTime(_now.year, _now.month, _now.day))
          .inDays;
      if (num == 0) {
        _todayList.add(e);
      } else if (num == -1) {
        _yesterdayList.add(e);
      } else {
        _recentlyList.add(e);
      }
    }
  }

  DiaryModel detailDiary(DiaryModel diaryModel) => diaryModel;

  void createDiary(DiaryModel diaryModel) {
    _dbHelper.createDiary(diaryModel);
    _seperateDiary();
    notifyListeners();
  }

  void updateDiary(
      DiaryModel diaryModel,
      String? title,
      String? description,
      Uint8List? imageUrl,
      List<String>? tags,
      String? mood,
      bool? isStarred,
      DateTime? dateTime,
      DateTime? updated) {
    _dbHelper.updateDiary(diaryModel, title, description, imageUrl, tags, mood,
        isStarred, dateTime, updated);

    notifyListeners();
  }

  void deleteDiary(DiaryModel diaryModel) {
    _dbHelper.deleteDiary(diaryModel);
    _seperateDiary();
    notifyListeners();
  }

  /* All about starred */

  bool getStarred(DiaryModel diaryModel) {
    _isStarred = diaryModel.isStarred;
    return _isStarred;
  }

  void setStarred(DiaryModel diaryModel, bool isStarred) {
    _isStarred = !isStarred;
    _dbHelper.setStarred(diaryModel);
    notifyListeners();
  }

  List<DiaryModel> getAllStarredDiaries() =>
      _dbHelper.allDiaries().where((e) => e.isStarred == true).toList();

  List<DiaryModel> starredDiariesList = [];

  void searchStarredDiary(String value) {
    List<DiaryModel> allStarreddiaries = getAllStarredDiaries();
    starredDiariesList.clear();
    for (var diaryModel in allStarreddiaries) {
      if (diaryModel.title.toLowerCase().contains(value)) {
        starredDiariesList.add(diaryModel);
        notifyListeners();
      }
    }
  }

  /* All about search diary */

  List<DiaryModel> searchList = [];

  void searchDiary(String value) {
    List<DiaryModel> alldiaries = _dbHelper.allDiaries();
    searchList.clear();
    for (var diaryModel in alldiaries) {
      if (diaryModel.title.toLowerCase().contains(value)) {
        searchList.add(diaryModel);
        notifyListeners();
      }
    }
  }
}
