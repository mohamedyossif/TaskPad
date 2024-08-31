import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_pad/Features/ToDoTasks/model/notification_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static _onTap(NotificationResponse response) {
    log(response.id.toString());
  }

  static Future<void> initialLocalNotification() async {
// Android Initialization
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );
  }

  static Future<void> showDailySchduledNotification(String message) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Channel for daily notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      9,
    );
    //every 24 hour add 1 day
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(hours: 12));
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'Daily Schduled Notification',
      message,
      scheduleTime,
      details,
      payload: 'zonedSchedule',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleNotification(
      NotificationModel notification) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel_idTask',
        'Channel_titleTask',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );
    tz.initializeTimeZones();
    // to get local location
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    // tz package is bad to get hour in cairo
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    return await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.notificationMessage,
        tz.TZDateTime(
          tz.local,
          notification.year,
          notification.months,
          notification.day,
          notification.hours,
          notification.minute,
        ),
        details,
        payload: notification.title,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
