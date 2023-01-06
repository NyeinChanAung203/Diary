import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkTheme = false;
  Color primaryColor = defaultColor;
  int mainColor = 0;

  ThemeMode get themeMode {
    if (darkTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  changeTheme(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('theme', value);
    darkTheme = value;
    notifyListeners();
  }

  changeColor(int value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('mainColor', value);
    mainColor = value;
  }

  initialize() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    darkTheme = preferences.getBool('theme') ?? false;
    mainColor = preferences.getInt('mainColor') ?? 0;
    changeMaincolor(mainColor);
    notifyListeners();
  }

  void changeMaincolor(int index) {
    switch (index) {
      case 0:
        primaryColor = defaultColor;
        break;
      case 1:
        primaryColor = blueColor;
        break;
      case 2:
        primaryColor = redColor;
        break;
      case 3:
        primaryColor = yellowColor;
        break;
      case 4:
        primaryColor = purpleColor;
        break;
      case 5:
        primaryColor = greyColor;
        break;
      case 6:
        primaryColor = greenColor;
        break;
      case 7:
        primaryColor = pinkColor;
        break;
      case 8:
        primaryColor = cyanColor;
        break;
    }
    changeColor(index);
    notifyListeners();
  }
}
