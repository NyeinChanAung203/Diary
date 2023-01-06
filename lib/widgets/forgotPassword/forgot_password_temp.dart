import 'package:diary/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class ForgotPasswordTem extends StatelessWidget {
  const ForgotPasswordTem({
    Key? key,
    required this.canPop,
    required this.title,
    this.subtitle,
    this.onPressBack,
    this.onTapOk,
    this.isFailedMessage,
    this.questionController,
    this.answerController,
    required this.readOnly,
    required this.formKey,
  }) : super(key: key);

  final void Function()? onPressBack;
  final Widget? isFailedMessage;
  final String title;
  final String? subtitle;
  final GlobalKey<FormState> formKey;
  final bool canPop, readOnly;

  final void Function()? onTapOk;

  final TextEditingController? questionController, answerController;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'value': 'What is your favorite movie?',
        'label': 'What is your favorite movie?',
      },
      {
        'value': 'What is your favorite color?',
        'label': 'What is your favorite color?',
      },
      {
        'value': 'What is your favorite food?',
        'label': 'What is your favorite food?',
      },
    ];
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            canPop
                ? Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      splashRadius: 20,
                      iconSize: 40,
                      color: Theme.of(context).colorScheme.primary,
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                      onPressed: onPressBack,
                    ),
                  )
                : const SizedBox(),
            /* Background box decoration */
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                width: 200,
                height: 200,
                transform: Matrix4.rotationZ(12),
                decoration: BoxDecoration(
                  color: boxColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 120,
              right: 0,
              child: Container(
                width: 80,
                height: 80,
                transform: Matrix4.rotationZ(12),
                decoration: BoxDecoration(
                  color: boxColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 30,
              child: Container(
                width: 100,
                height: 100,
                transform: Matrix4.rotationZ(12),
                decoration: BoxDecoration(
                  color: boxColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            /* Content */
            Positioned(
              top: 60,
              child: SizedBox(
                // color: Colors.blue,
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        subtitle ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 300,
                                child: SelectFormField(
                                  readOnly: readOnly,
                                  controller: questionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your question';
                                    }
                                    return null;
                                  },
                                  type: SelectFormFieldType
                                      .dropdown, // or can be dialog
                                  // initialValue: '',
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Select your question'),
                                  items: items,
                                  onChanged: (val) => debugPrint(val),
                                  // onSaved: (val) => debugPrint(val),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  child: TextFormField(
                                    controller: answerController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please answer the question';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Please answer the question',
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            isFailedMessage ?? const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: onTapOk, child: const Text('OK')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
