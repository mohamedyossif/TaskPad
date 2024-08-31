import 'package:task_pad/Core/helper/local_notification.dart';
import 'package:task_pad/Features/ToDoTasks/model/notification_model.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerNotification {
  static Workmanager workmanager = Workmanager();
  static Future<void> registerMyTask() async {
    //register my task
    await workmanager.registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(minutes: 15),
    );
  }

  static Future<void> registerScheduleTask(
      NotificationModel notification) async {
    await workmanager.registerOneOffTask(
      notification.id.toString(),
      'ScheduleTask${notification.id}',
      inputData: notification.toMap(),
    );
  }

  static Future<void> cancelNotification(uniqueName) async {
    await workmanager.cancelByUniqueName(uniqueName);
  }

  static Future<void> cancelAllNotification() async {
    await workmanager.cancelAll();
  }

  //init work manager service
  static Future<void> init() async {
    await workmanager.initialize(actionTask);
    await registerMyTask();
  }
}

@pragma('vm-entry-point')
void actionTask() {
  //show notification
  Workmanager().executeTask((taskName, inputData) async {
    NotificationModel notificationModel = NotificationModel.fromMap(inputData!);
    await LocalNotification.scheduleNotification(notificationModel);

    await LocalNotification.showDailySchduledNotification(
        notificationModel.dailyMessage);

    return Future.value(true);
  });
}
