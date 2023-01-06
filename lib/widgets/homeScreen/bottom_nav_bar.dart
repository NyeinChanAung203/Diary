import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final Function(int)? onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        showUnselectedLabels: true,
        elevation: 5,
        currentIndex: currentIndex,
        selectedItemColor: primaryColor,
        selectedLabelStyle: const TextStyle(color: primaryColor),
        unselectedItemColor: Theme.of(context).textTheme.titleLarge!.color,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calender'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sentiment_satisfied_alt), label: 'Mood'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Tags'),
        ]);
  }
}
