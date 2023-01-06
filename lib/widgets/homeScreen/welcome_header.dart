import 'package:diary/providers/theme_provider.dart';
import 'package:diary/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      padding: const EdgeInsets.only(left: 50),
      decoration: BoxDecoration(
        color: context
            .watch<ThemeProvider>()
            .primaryColor, //Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Hello ${context.watch<UserProvider>().getUserName() ?? ''},',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Hope Your day was going well.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            DateFormat.yMMMMd('en_US').format(DateTime.now()),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ]),
    );
  }
}
