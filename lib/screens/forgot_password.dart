import 'package:diary/database/hive_database.dart';
import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/routes/routes.dart';

import 'package:diary/widgets/forgotPassword/forgot_password_temp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key, required this.isChangeQues})
      : super(key: key);
  final bool isChangeQues;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    super.initState();
    questionController.text = _dbHelper.getPasswordModel()!.question!.keys.last;
    final provider = Provider.of<SetPasswordProvider>(context, listen: false);
    provider.isFailed = false;
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final DbHelper _dbHelper = DbHelper.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordTem(
        isFailedMessage: Consumer<SetPasswordProvider>(
          builder: (context, value, child) {
            return value.isFailed
                ? const Text(
                    'Incorrect Answer',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox();
          },
        ),
        readOnly: true,
        canPop: true,
        formKey: formKey,
        title: widget.isChangeQues
            ? 'Answer Security Question'
            : 'Forgot Password?',
        questionController: questionController,
        answerController: answerController,
        onPressBack: () {
          Navigator.of(context).pop();
        },
        onTapOk: () {
          if (formKey.currentState!.validate()) {
            debugPrint('valid');
            debugPrint(answerController.text);
            debugPrint(questionController.text);
            String dbAnswer = _dbHelper
                .getPasswordModel()!
                .question![questionController.text]!;
            bool same = Provider.of<SetPasswordProvider>(context, listen: false)
                .checkSecurityQuestion(dbAnswer, answerController.text);
            if (same) {
              if (widget.isChangeQues) {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.setSecurityQues);
              } else {
                Provider.of<SetPasswordProvider>(context, listen: false)
                  ..isNewPasswordSet = true
                  ..isForgot = true;

                Navigator.of(context).pushReplacementNamed(
                    Routes.passwordSetting,
                    arguments: true);
              }
            }
          }
        },
      ),
    );
  }
}
