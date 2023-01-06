import 'dart:async';

import 'package:diary/database/hive_database.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/utils/asset_image_url.dart';
import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DbHelper _dbHelper = DbHelper.instance();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      PasswordModel? pass = _dbHelper.getPasswordModel();
      // print('Password : ${pass?.password}, question: ${pass?.question}');
      // pass?.delete();
      // var u = _dbHelper.getUserProfile();
      // u?.delete();
      void checkUser() {
        var user = _dbHelper.getUserProfile();
        // print('Name: ${user?.name}');
        if (user == null) {
          Navigator.of(context).pushReplacementNamed(Routes.onBoarding);
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        }
      }

      if (pass != null) {
        // print('pass not null');
        if (pass.islock) {
          Navigator.pushReplacementNamed(context, Routes.password);
        } else {
          checkUser();
        }
      } else {
        checkUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image(
          width: MediaQuery.of(context).size.width * 0.8,
          image: const AssetImage(splahImage),
        ),
      ),
    );
  }
}
