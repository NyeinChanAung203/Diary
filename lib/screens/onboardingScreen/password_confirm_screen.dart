import 'package:diary/database/hive_database.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/passwordSetting/password_setting_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordConfirmScreen extends StatelessWidget {
  const PasswordConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SetPasswordProvider>(context, listen: false);
    DbHelper dbHelper = DbHelper.instance();

    return Scaffold(
      body: PasswordSettingTemplate(
        canPop: true,
        onTapOne: () => provider.addConfirmPassword('1'),
        onTapTwo: () => provider.addConfirmPassword('2'),
        onTapThree: () => provider.addConfirmPassword('3'),
        onTapFour: () => provider.addConfirmPassword('4'),
        onTapFive: () => provider.addConfirmPassword('5'),
        onTapSix: () => provider.addConfirmPassword('6'),
        onTapSeven: () => provider.addConfirmPassword('7'),
        onTapEight: () => provider.addConfirmPassword('8'),
        onTapNine: () => provider.addConfirmPassword('9'),
        onTapZero: () => provider.addConfirmPassword('0'),
        onTapBackSpace: () => provider.removeConfirmPassword(),
        isFailedMessage: Consumer<SetPasswordProvider>(
          builder: (context, value, child) {
            return value.isFailed
                ? const Text(
                    'Password does not match',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox();
          },
        ),
        onTapOk: () {
          if (provider.confirmPassword.length == 4) {
            bool isSame = provider.arePasswordSame(
                provider.password, provider.confirmPassword);
            if (isSame) {
              String password = provider.password.join().toString();
              if (provider.isNewPasswordSet) {
                provider.isNewPasswordSet = false;
                final pw = dbHelper.getPasswordModel();
                final oldSecurityQues = pw?.question;
                pw?.delete();
                dbHelper.createPassword(PasswordModel(
                    password: password,
                    islock: true,
                    question: oldSecurityQues));
                if (provider.isForgot) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.password, (route) => false);
                } else {
                  Navigator.of(context)
                    ..pop()
                    ..pop()
                    ..pop();
                }
              } else {
                provider.createPassword(
                    PasswordModel(password: password, islock: true));
                Navigator.of(context)
                    .pushReplacementNamed(Routes.setSecurityQues);
              }
              provider.resetAll();
            }
          }
          debugPrint(
              "password = ${provider.password}, confirm = ${provider.confirmPassword} ");
        },
        title: 'Confirm Password',
        subtitle: 'Please enter password again',
        onPressBack: () {
          provider.clearConfirmPassword();

          Navigator.of(context).pop();
        },
        passwordCircleList: List.generate(
            4,
            (index) => Consumer<SetPasswordProvider>(
                  builder: (context, value, child) {
                    return CircleAvatar(
                      backgroundColor: value.confirmPassword.length > index
                          ? primaryColor
                          : inActiveColor,
                      radius: 10,
                    );
                  },
                )),
      ),
    );
  }
}
