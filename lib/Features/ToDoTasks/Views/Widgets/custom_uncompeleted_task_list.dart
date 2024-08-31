import 'package:flutter/material.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_uncompeleted_to_do_item.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class CustomUnCompeletedTaskList extends StatelessWidget {
  const CustomUnCompeletedTaskList({super.key, required this.tasksUncompleted});
  final List<ToDoTaskModel> tasksUncompleted;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => CustomUncompeletedToDoItem(
        task: tasksUncompleted[index],
      ),
      itemCount: tasksUncompleted.length,
    );
  }
}
