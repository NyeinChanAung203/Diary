import 'package:diary/database/hive_database.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/screens/onboardingScreen/onboarding_screen.dart';
import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/passwordSetting/password_setting_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key, this.isChangePassword}) : super(key: key);

  final bool? isChangePassword;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SetPasswordProvider>(context, listen: false);
    provider.isFailed = false;
    final DbHelper dbHelper = DbHelper.instance();
    return Scaffold(
      body: PasswordSettingTemplate(
        canPop: false,
        onTapOne: () => provider.addPassword('1'),
        onTapTwo: () => provider.addPassword('2'),
        onTapThree: () => provider.addPassword('3'),
        onTapFour: () => provider.addPassword('4'),
        onTapFive: () => provider.addPassword('5'),
        onTapSix: () => provider.addPassword('6'),
        onTapSeven: () => provider.addPassword('7'),
        onTapEight: () => provider.addPassword('8'),
        onTapNine: () => provider.addPassword('9'),
        onTapZero: () => provider.addPassword('0'),
        onTapBackSpace: () => provider.removePassword(),
        onForgotTap: isChangePassword != null
            ? null
            : () => Navigator.of(context).pushNamed(Routes.securityQues),
        isFailedMessage: Consumer<SetPasswordProvider>(
          builder: (context, value, child) {
            return value.isFailed
                ? const Text(
                    'Incorrect Password',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox();
          },
        ),
        onTapOk: () {
          if (provider.password.length == 4) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    )));

            PasswordModel? pw = dbHelper.getPasswordModel();
            var user = dbHelper.getUserProfile();

            if (pw != null) {
              bool same = provider.checkRealPassword(
                  pw.password!, provider.password.join());
              if (same) {
                // clear password from provider
                provider.resetAll();
                //condition
                if (isChangePassword != null && isChangePassword == true) {
                  provider.isNewPasswordSet = true;
                  Navigator.of(context).pushReplacementNamed(
                    Routes.passwordSetting,
                    arguments: true,
                  );
                } else if (pw.question == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.setSecurityQues, (route) => false);
                } else if (user == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (_) => const OnBoardingScreen(
                                pageIndex: 2,
                              )),
                      // Routes.onBoarding,
                      (route) => false);
                } else {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                }
              } else {
                Navigator.of(context).pop();
              }
            } else {
              debugPrint('something went wrong');
            }
          }
        },
        title: 'Password',
        subtitle: isChangePassword != null
            ? isChangePassword!
                ? 'Enter current password'
                : 'Forgot password?'
            : 'Forgot password?',
        passwordCircleList: List.generate(
            4,
            (index) => Consumer<SetPasswordProvider>(
                  builder: (context, value, child) {
                    return CircleAvatar(
                      backgroundColor: value.password.length > index
                          ? primaryColor
                          : const Color.fromARGB(255, 105, 105, 105),
                      radius: 10,
                    );
                  },
                )),
      ),
    );
  }
}
