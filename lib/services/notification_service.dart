import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
        0, 'Diary', 'It is time to create your memories', notificationDetails);
  }

  void scheduleNotification(bool isDaily) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Diary',
        'It is time to create your memories!',
        isDaily ? RepeatInterval.daily : RepeatInterval.weekly,
        notificationDetails);
  }

  void stopNotification() {
    _flutterLocalNotificationsPlugin.cancel(0);
  }
}
