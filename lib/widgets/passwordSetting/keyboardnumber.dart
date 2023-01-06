import 'package:flutter/material.dart';

class KeyboardNumber extends StatelessWidget {
  const KeyboardNumber({
    Key? key,
    required this.text,
    this.onTap,
    this.icon,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;

  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return icon != null
        ? IconButton(
            iconSize: 30,
            icon: Icon(
              icon,
              color: Theme.of(context).textTheme.headlineMedium!.color,
            ),
            onPressed: onTap,
          )
        : TextButton(
            onPressed: onTap,
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
  }
}
