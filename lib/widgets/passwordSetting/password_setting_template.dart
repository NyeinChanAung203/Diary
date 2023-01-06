import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/passwordSetting/keyboardnumber.dart';
import 'package:flutter/material.dart';

class PasswordSettingTemplate extends StatelessWidget {
  const PasswordSettingTemplate({
    Key? key,
    required this.title,
    required this.subtitle,
    this.canPop,
    this.onPressBack,
    required this.passwordCircleList,
    this.onTapOne,
    this.onTapTwo,
    this.onTapThree,
    this.onTapFour,
    this.onTapFive,
    this.onTapSix,
    this.onTapSeven,
    this.onTapEight,
    this.onTapNine,
    this.onTapZero,
    this.onTapBackSpace,
    this.onTapOk,
    this.isFailedMessage,
    this.onForgotTap,
  }) : super(key: key);

  final void Function()? onPressBack;
  final Widget? isFailedMessage;
  final String title, subtitle;
  final bool? canPop;
  final List<Widget> passwordCircleList;
  final void Function()? onTapOne;
  final void Function()? onTapTwo;
  final void Function()? onTapThree;
  final void Function()? onTapFour;
  final void Function()? onTapFive;
  final void Function()? onTapSix;
  final void Function()? onTapSeven;
  final void Function()? onTapEight;
  final void Function()? onTapNine;
  final void Function()? onTapZero;
  final void Function()? onTapBackSpace;
  final void Function()? onTapOk;
  final void Function()? onForgotTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            (canPop != null && canPop == true)
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
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: passwordCircleList,
                      ),
                    ),
                    InkWell(
                      onTap: onForgotTap,
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    isFailedMessage ?? const SizedBox()
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          KeyboardNumber(
                            text: '1',
                            onTap: onTapOne,
                          ),
                          KeyboardNumber(
                            text: '2',
                            onTap: onTapTwo,
                          ),
                          KeyboardNumber(
                            text: '3',
                            onTap: onTapThree,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          KeyboardNumber(
                            text: '4',
                            onTap: onTapFour,
                          ),
                          KeyboardNumber(
                            text: '5',
                            onTap: onTapFive,
                          ),
                          KeyboardNumber(
                            text: '6',
                            onTap: onTapSix,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          KeyboardNumber(
                            text: '7',
                            onTap: onTapSeven,
                          ),
                          KeyboardNumber(
                            text: '8',
                            onTap: onTapEight,
                          ),
                          KeyboardNumber(
                            text: '9',
                            onTap: onTapNine,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          KeyboardNumber(
                            text: 'x',
                            icon: Icons.backspace,
                            onTap: onTapBackSpace,
                          ),
                          KeyboardNumber(
                            text: '0',
                            onTap: onTapZero,
                          ),
                          KeyboardNumber(
                            text: 'ok',
                            icon: Icons.check,
                            onTap: onTapOk,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
