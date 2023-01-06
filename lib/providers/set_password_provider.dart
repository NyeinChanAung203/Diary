import 'package:diary/database/hive_database.dart';
import 'package:diary/models/password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SetPasswordProvider extends ChangeNotifier {
  final List<String> _password = [];
  List<String> confirmPassword = [];
  bool isFailed = false;
  bool isNewPasswordSet = false;
  bool isForgot = false;

  List<String> get password => _password;

  void clearPassword() => _password.clear();

  final DbHelper _dbHelper = DbHelper.instance();

  bool? isLock() {
    return _dbHelper.getPasswordModel()?.islock;
  }

  void createPassword(PasswordModel passwordModel) {
    _dbHelper.createPassword(passwordModel);
    notifyListeners();
  }

  // void toggleLock(
  //   PasswordModel passwordModel,
  // ) {
  //   _dbHelper.toggleLockApp(passwordModel);
  //   notifyListeners();
  // }

  void addPassword(String value) {
    if (_password.length < 4) {
      _password.add(value);
      notifyListeners();
      debugPrint(password.toString());
    }
  }

  void removePassword() {
    if (_password.isNotEmpty) _password.removeLast();
    notifyListeners();
    debugPrint(password.toString());
  }

  void addConfirmPassword(String value) {
    if (confirmPassword.length < 4) {
      confirmPassword.add(value);
      notifyListeners();
      debugPrint(confirmPassword.toString());
    }
  }

  void removeConfirmPassword() {
    if (confirmPassword.isNotEmpty) confirmPassword.removeLast();
    notifyListeners();
    debugPrint(confirmPassword.toString());
  }

  void clearConfirmPassword() {
    confirmPassword = [];
    isFailed = false;
    notifyListeners();
  }

  void resetAll() {
    _password.clear();
    confirmPassword.clear();
    isFailed = false;
    isForgot = false;
    isNewPasswordSet = false;
    notifyListeners();
  }

  bool arePasswordSame(List<String> pw, List<String> cpw) {
    // check if elements are equal
    for (int i = 0; i < pw.length; i++) {
      if (pw[i] != cpw[i]) {
        confirmFailedAction();
        return false;
      }
    }

    return true;
  }

  bool checkRealPassword(String realPw, String pw) {
    if (realPw == pw) {
      isFailed = false;
      notifyListeners();
      return true;
    } else {
      isFailed = true;
      notifyListeners();
      return false;
    }
  }

  bool checkSecurityQuestion(String realAns, String ans) {
    if (realAns == ans) {
      isFailed = false;
      notifyListeners();
      return true;
    } else {
      isFailed = true;
      notifyListeners();
      return false;
    }
  }

  void confirmFailedAction() {
    isFailed = true;
    confirmPassword = [];
    notifyListeners();
  }
}
