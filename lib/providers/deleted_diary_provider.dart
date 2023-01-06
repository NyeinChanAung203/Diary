import 'package:diary/database/hive_database.dart';
import 'package:diary/models/deleted_diary_model.dart';
import 'package:flutter/widgets.dart';

class DeletedDiaryProvider extends ChangeNotifier {
  final DbHelper _dbHelper = DbHelper.instance();

  List<DeletedDiaryModel> getAllDeletedDiaries() =>
      _dbHelper.allDeletedDiaries();

  List<DeletedDiaryModel> deletedDiariesSearchList = [];

  void searchdeletedDiary(String value) {
    List<DeletedDiaryModel> alldeletedDiaries = getAllDeletedDiaries();
    deletedDiariesSearchList.clear();
    for (var deletedDiaryModel in alldeletedDiaries) {
      if (deletedDiaryModel.title.toLowerCase().contains(value)) {
        deletedDiariesSearchList.add(deletedDiaryModel);
        notifyListeners();
      }
    }
  }

  createDeletedDiary(DeletedDiaryModel deletedDiaryModel) {
    _dbHelper.createDeletedDiary(deletedDiaryModel);
    notifyListeners();
  }

  deleteDeletedDiary(DeletedDiaryModel deletedDiaryModel) {
    _dbHelper.deleteDeletedDiary(deletedDiaryModel);
    notifyListeners();
  }

  List<DeletedDiaryModel> selectedDiaries = [];
  bool selectMode = false;

  void disableSelectionMode() {
    selectMode = false;
    selectedDiaries.clear();
    notifyListeners();
  }

  void turnOnSelectionMode() {
    selectMode = true;
    notifyListeners();
  }

  // void onLongPress(DeletedDiaryModel deletedDiaryModel) {
  //   selectMode = true;
  //   selectedDiaries.add(deletedDiaryModel);
  //   notifyListeners();
  // }

  void onTap(DeletedDiaryModel deletedDiaryModel) {
    if (selectMode) {
      bool contain = selectedDiaries.contains(deletedDiaryModel);
      if (contain) {
        selectedDiaries.remove(deletedDiaryModel);
      } else {
        selectedDiaries.add(deletedDiaryModel);
      }
      notifyListeners();
    }
  }

  void selectAll() {
    selectedDiaries.clear();
    selectedDiaries.addAll(getAllDeletedDiaries());
    notifyListeners();
  }

  void deleteSelectedDiaries(List<DeletedDiaryModel> deletedDiaryModelList) {
    for (var element in deletedDiaryModelList) {
      element.delete();
    }
    disableSelectionMode();
  }
}
