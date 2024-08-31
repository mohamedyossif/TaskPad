import 'package:task_pad/Core/Utils/constants.dart';

class ToDoTaskModel {
  int? id;
  String date;
  String title;
  int isCompeleted;
  ToDoTaskModel({
    required this.title,
    required this.date,
    this.isCompeleted = 0,
    this.id,
  });
  factory ToDoTaskModel.fromMap(Map<String, dynamic> map) => ToDoTaskModel(
        id: map[kId],
        title: map[kTitle],
        date: map[kDate],
        isCompeleted: map[kTaskIsCompeleted],
      );
  toMap() {
    return {
      kId: id,
      kTitle: title,
      kDate: date,
      kTaskIsCompeleted: isCompeleted
    };
  }
}
