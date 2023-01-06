import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  // to be one instance
  MyTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.light,
      primary: primaryTextColor,
      secondary: primaryColor,
      onSecondary: Colors.grey,
      background: scaffoldBgColor,
      onBackground: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: primaryTextColor,
    ),
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
          foregroundColor: MaterialStateProperty.all(const Color(0xFFfbfbfb)),
          backgroundColor: MaterialStateProperty.all(primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ),
    textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: primaryTextColor,
          fontSize: 30,
        ),
        headlineMedium: TextStyle(color: Colors.white),
        titleLarge:
            TextStyle(fontWeight: FontWeight.w500, color: primaryTextColor),
        titleMedium: TextStyle(color: primaryTextColor),
        titleSmall: TextStyle(color: searchBgColor)),
    drawerTheme: const DrawerThemeData(backgroundColor: primaryTextColor),
    dividerColor: Colors.transparent,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xffF5EBD7),
      secondary: Color(0xff464646),
      background: Color(0xff212121),
      onBackground: Color(0xff464646),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFF5EBD7),
    ),
    fontFamily: GoogleFonts.ubuntu().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
          foregroundColor: MaterialStateProperty.all(const Color(0xff212121)),
          backgroundColor: MaterialStateProperty.all(primaryColor),
          side:
              MaterialStateProperty.all(const BorderSide(color: primaryColor)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffF5EBD7),
        fontSize: 30,
      ),
      headlineMedium: TextStyle(color: primaryColor),
      titleLarge:
          TextStyle(fontWeight: FontWeight.w500, color: Color(0xffCCC5B8)),
      titleMedium: TextStyle(color: Color(0xffF5EBD7)),
      titleSmall: TextStyle(color: Color(0xff505050)),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffF5EBD7)),
    dividerColor: Colors.transparent,
  );
}
