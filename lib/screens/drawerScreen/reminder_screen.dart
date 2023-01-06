import 'package:diary/providers/theme_provider.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:diary/services/notification_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.initialiseNotifications();
  }

  final TextEditingController controller = TextEditingController();

  void selectTime(BuildContext context) async {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light().copyWith(
                primary: context.read<ThemeProvider>().primaryColor,
              )),
              child: child!);
        });

    (time);
  }

  final List<Map<String, dynamic>> items = [
    {
      'value': 'Daily reminder',
      'label': 'Daily reminder',
    },
    {
      'value': 'Weekly reminder',
      'label': 'Weekly reminder',
    },
    // {
    //   'value': 'Monthly reminder',
    //   'label': 'Monthly reminder',
    // },
  ];

  String reminderType = 'Daily reminder';
  bool turnOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
              title: Text('Reminder',
                  style: Theme.of(context).textTheme.titleLarge)),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading:
                Icon(Icons.alarm, color: Theme.of(context).iconTheme.color),
            title: SelectFormField(
              // controller: controller,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
              initialValue: items[0]['label'].toString(),
              type: SelectFormFieldType.dropdown,
              onChanged: (e) {
                reminderType = e;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              items: items,
            ),
            trailing: Switch(
              activeColor: context.read<ThemeProvider>().primaryColor,
              activeTrackColor:
                  context.read<ThemeProvider>().primaryColor.withOpacity(0.5),
              onChanged: (value) {
                if (value) {
                  turnOn = value;

                  if (reminderType == 'Daily reminder') {
                    notificationService.scheduleNotification(true);
                  } else {
                    notificationService.scheduleNotification(false);
                  }
                  setState(() {});
                } else {
                  turnOn = value;
                  notificationService.stopNotification();
                  setState(() {});
                }
              },
              value: turnOn,
            ),
          ),
          //   ListTile(
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          //       leading: Icon(Icons.notifications_active,
          //           color: Theme.of(context).iconTheme.color),
          //       title: Text(
          //         'Alarm time',
          //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //               color: Theme.of(context).textTheme.titleMedium!.color,
          //             ),
          //       ),
          //       trailing: TextButton(
          //         onPressed: () {
          //           selectTime(context);
          //         },
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Text(
          //               '12:30 PM',
          //               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //                     color:
          //                         Theme.of(context).textTheme.titleMedium!.color,
          //                   ),
          //             ),
          //             const Icon(
          //               Icons.arrow_drop_down,
          //               color: primaryTextColor,
          //             ),
          //           ],
          //         ),
          //       )),
          //
        ],
      )),
    );
  }
}
