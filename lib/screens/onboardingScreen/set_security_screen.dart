import 'package:diary/database/hive_database.dart';

import 'package:diary/routes/routes.dart';

import 'package:diary/screens/onboardingScreen/onboarding_screen.dart';
import 'package:diary/widgets/forgotPassword/forgot_password_temp.dart';
import 'package:flutter/material.dart';

class SetSecurityScreen extends StatelessWidget {
  const SetSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? questionController = TextEditingController();
    TextEditingController? answerController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();
    final DbHelper dbHelper = DbHelper.instance();

    return Scaffold(
        body: ForgotPasswordTem(
      readOnly: false,
      canPop: false,
      formKey: formKey,
      onPressBack: () {
        Navigator.of(context).pop();
      },
      onTapOk: () {
        if (formKey.currentState!.validate()) {
          debugPrint('valid');
          debugPrint(answerController.text);
          debugPrint(questionController.text);
          Map<String, String> question = {
            questionController.text.trim():
                answerController.text.trim().toLowerCase()
          };
          dbHelper.createQuestion(question);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Row(
                children: const [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('success'),
                ],
              )));
          var user = dbHelper.getUserProfile();
          if (user != null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const OnBoardingScreen(
                      pageIndex: 2,
                    )));
          }
        }
      },
      title: 'Set up security questions',
      subtitle:
          'You can set up a security question in case your forgot password.',
      questionController: questionController,
      answerController: answerController,
    ));
  }
}
