import 'package:flutter/material.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/body_bottom_sheet.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

Future<dynamic> openBottomSheet(
    BuildContext context, ToDoTaskModel? taskModel) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    context: context,
    builder: (context) => BodyBottomSheet(
      taskModel: taskModel,
    ),
  );
}
