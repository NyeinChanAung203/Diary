import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/passwordSetting/password_setting_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordSettingScreen extends StatelessWidget {
  const PasswordSettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SetPasswordProvider>(context, listen: false);
    provider.clearPassword();
    return Scaffold(
      body: PasswordSettingTemplate(
        canPop: true,
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
        onTapOk: () {
          if (provider.password.length == 4) {
            Navigator.of(context).pushNamed(Routes.passwordConfirm);
          }
        },
        onPressBack: () {
          Navigator.of(context).pop();
        },
        title: 'Set ${provider.isNewPasswordSet ? 'New' : ''} Password',
        subtitle:
            'Please enter ${provider.isNewPasswordSet ? 'new' : ''} password',
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
