import 'package:flutter/material.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_compeleted_to_do_item%20.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_uncompeleted_to_do_item.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class CustomSearchAboutTasks extends StatelessWidget {
  const CustomSearchAboutTasks({
    super.key,
    required this.tasks,
  });
  final List<ToDoTaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => tasks[index].isCompeleted == 0
            ? CustomUncompeletedToDoItem(task: tasks[index])
            : CustomCompeletedToDoItem(task: tasks[index]),
        itemCount: tasks.length,
      ),
    );
  }
}
