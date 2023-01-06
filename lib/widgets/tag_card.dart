import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  const TagCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.01),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: primaryTextColor,
            ),
      ),
    );
  }
}
