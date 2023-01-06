import 'package:diary/models/deleted_diary_model.dart';
import 'package:diary/models/diary_model.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/models/user_profile_model.dart';

import 'package:diary/providers/deleted_diary_provider.dart';
import 'package:diary/providers/diary_provider.dart';
import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/providers/theme_provider.dart';
import 'package:diary/providers/user_provider.dart';

import 'package:diary/routes/route_manager.dart';

import 'package:diary/screens/splash_screen.dart';

import 'package:diary/themes/theme.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserProfileAdapter());
  await Hive.openBox<UserProfile>('userProfile');

  Hive.registerAdapter(PasswordModelAdapter());
  await Hive.openBox<PasswordModel>('security');

  Hive.registerAdapter(DiaryModelAdapter());
  await Hive.openBox<DiaryModel>('diaries');

  Hive.registerAdapter(DeletedDiaryModelAdapter());
  await Hive.openBox<DeletedDiaryModel>('deleted_diaries');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SetPasswordProvider()),
        ChangeNotifierProvider(create: (context) => DiaryProvider()),
        ChangeNotifierProvider(create: (context) => DeletedDiaryProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..initialize()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, modeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Diary',
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            themeMode: modeProvider.themeMode,
            // initialRoute: Routes.passwordSetting,
            onGenerateInitialRoutes: (s) => [
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            ],
            onGenerateRoute: RouteManager.generateRoute,
          );
        },
      ),
    );
  }
}
