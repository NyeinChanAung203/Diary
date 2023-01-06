import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    this.bgColor,
    this.onPop,
    this.fullScreenDialog = false,
  }) : super(key: key);

  final Widget title;
  final Widget? action;
  final Color? bgColor;
  final bool fullScreenDialog;
  final void Function()? onPop;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 50,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 0),
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: bgColor ?? Theme.of(context).colorScheme.onBackground,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Row(
          children: [
            IconButton(
                iconSize: 30,
                onPressed: onPop ??
                    () {
                      Navigator.of(context).pop();
                    },
                icon: Icon(
                  fullScreenDialog ? Icons.close_rounded : Icons.chevron_left,
                  color: Theme.of(context).colorScheme.primary,
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Expanded(child: title),
                  const SizedBox(
                    width: 10,
                  ),
                  action ?? const SizedBox(),
                ],
              ),
            ))
          ],
        ));
  }
}
