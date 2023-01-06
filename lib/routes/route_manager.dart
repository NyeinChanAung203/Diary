import 'package:diary/models/diary_model.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/screens/drawerScreen/deleted_screen.dart';
import 'package:diary/screens/drawerScreen/profile_edit_screen.dart';
import 'package:diary/screens/drawerScreen/reminder_screen.dart';
import 'package:diary/screens/drawerScreen/security_screen.dart';
import 'package:diary/screens/drawerScreen/starred_screen.dart';
import 'package:diary/screens/drawerScreen/theme_screen.dart';
import 'package:diary/screens/forgot_password.dart';

import 'package:diary/screens/homeScreen/diary_detail_screen.dart';

import 'package:diary/screens/homeScreen/home_screen.dart';
import 'package:diary/screens/homeScreen/recent_screen.dart';
import 'package:diary/screens/homeScreen/search_screen.dart';
import 'package:diary/screens/homeScreen/today_screen.dart';
import 'package:diary/screens/homeScreen/yesterday_screen.dart';

import 'package:diary/screens/onboardingScreen/onboarding_screen.dart';
import 'package:diary/screens/onboardingScreen/password_confirm_screen.dart';
import 'package:diary/screens/onboardingScreen/passwordset_screen.dart';
import 'package:diary/screens/onboardingScreen/set_security_screen.dart';

import 'package:diary/screens/password_screen.dart';

import 'package:diary/screens/splash_screen.dart';
import 'package:diary/screens/unknown.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.onBoarding:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());

      case Routes.passwordSetting:
        return MaterialPageRoute(
            builder: (context) => const PasswordSettingScreen());

      case Routes.passwordConfirm:
        return MaterialPageRoute(
            builder: (context) => const PasswordConfirmScreen());

      case Routes.password:
        return MaterialPageRoute(builder: (context) => const PasswordScreen());

      case Routes.securityQues:
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(
                  isChangeQues: settings.arguments as bool,
                ));

      case Routes.setSecurityQues:
        return MaterialPageRoute(
            builder: (context) => const SetSecurityScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.search:
        return MaterialPageRoute(builder: (context) => const SearchScreen());

      case Routes.diaryDetail:
        return MaterialPageRoute(
            builder: (context) => DiaryDetailScreen(
                diaryModel: settings.arguments as DiaryModel));

      case Routes.theme:
        return MaterialPageRoute(builder: (context) => const ThemeScreen());

      case Routes.reminder:
        return MaterialPageRoute(builder: (context) => const ReminderScreen());

      case Routes.security:
        return MaterialPageRoute(builder: (context) => const SecurityScreen());

      case Routes.starred:
        return MaterialPageRoute(builder: (context) => const StarredScreen());

      case Routes.trash:
        return MaterialPageRoute(builder: (context) => const DeletedScreen());

      case Routes.profileEdit:
        return MaterialPageRoute(
            builder: (context) => const ProfileEditScreen());

      case Routes.today:
        return MaterialPageRoute(builder: (context) => const TodayScreen());
      case Routes.yesterday:
        return MaterialPageRoute(builder: (context) => const YesterdayScreen());
      case Routes.recent:
        return MaterialPageRoute(builder: (context) => const RecentScreen());

      default:
        return MaterialPageRoute(builder: (context) => const UnknownScreen());
    }
  }
}
