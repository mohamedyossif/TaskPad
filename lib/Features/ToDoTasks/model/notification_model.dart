import 'package:task_pad/Core/Utils/constants.dart';

class NotificationModel {
  int id;
  String title, notificationMessage, dailyMessage;
  int year, months, day, hours, minute;
  NotificationModel({
    required this.id,
    required this.title,
    required this.notificationMessage,
    required this.dailyMessage,
    required this.year,
    required this.months,
    required this.day,
    required this.hours,
    required this.minute,
  });
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map[kId],
      title: map[kTitle],
      notificationMessage: map['message'],
      dailyMessage: map['dailyMessage'],
      year: map['year'],
      months: map['months'],
      day: map['day'],
      hours: map['hours'],
      minute: map['minute'],
    );
  }
  toMap() {
    return {
      kId: id,
      kTitle: title,
      'message': notificationMessage,
      'dailyMessage': dailyMessage,
      "year": year,
      'months': months,
      'day': day,
      'hours': hours,
      "minute": minute
    };
  }
}
