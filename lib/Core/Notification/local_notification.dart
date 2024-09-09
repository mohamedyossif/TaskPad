import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/Widgets/custom_snack_bar.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static _onTap(NotificationResponse response) {
    if (response.payload != null && navigatorKey.currentState != null) {
      var context = navigatorKey.currentState!.context;
      // clear screen unitl specific screen
      GoRouter.of(context).replace(AppRoutes.homeTaskPadView);
      if (context.mounted) {
        context.read<BottomNavBarCubit>().chnageScreen(context, index: 1);
        customSnackBar(context, nameTask: response.payload!);
      }
    }
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

  static Future<void> scheduleNotification(
      ToDoTaskModel task, DateTime date, String message) async {
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
        task.id!,
        task.title,
        message,
        tz.TZDateTime(
          tz.local,
          date.year,
          date.month,
          date.day,
          date.hour,
          date.minute,
        ),
        details,
        payload: task.title,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future<void> cancelAllNotifications() async {
    return await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }
}
