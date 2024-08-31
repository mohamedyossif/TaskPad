import 'package:flutter/material.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_compeleted_to_do_item%20.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class CustomCompeletedTaskList extends StatelessWidget {
  const CustomCompeletedTaskList({super.key, required this.tasksCompleted});
  final List<ToDoTaskModel> tasksCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transation(context).compelete_tasks,
          style: AppStyles.textStyleRegulard20(context),
        ),
        ListView.builder(
          itemCount: tasksCompleted.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => CustomCompeletedToDoItem(
            task: tasksCompleted[index],
          ),
        ),
      ],
    );
  }
}
