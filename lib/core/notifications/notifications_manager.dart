import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationsManager {
  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/sol');

    DarwinInitializationSettings initializationSettingsiOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsiOS,
    );

    await notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (details) async {});
  }

  notificationsDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'ticker',
    ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) {
    return notificationsPlugin.show(id, title, body, notificationsDetails());
  }
}
