import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/helper/local_notification.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/open_bottom_sheet.dart';

class CustomCompeletedToDoItem extends StatelessWidget {
  const CustomCompeletedToDoItem({super.key, required this.task});
  final ToDoTaskModel task;
  @override
  Widget build(BuildContext context) {
    var cubitTasks = BlocProvider.of<ToDoTasksCubit>(context);

    return GestureDetector(
      onTap: () => openBottomSheet(context, task),
      child: Dismissible(
        key: Key(task.id.toString()),
        background: Container(
          color: AppColors.redColor,
          alignment: Localizations.localeOf(context).languageCode == 'en'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: AppColors.whiteColor),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await Future.wait([
            LocalNotification.cancelNotification(task.id!),
            cubitTasks.deleteToDoTask(toDoTask: task),
          ]);
        },
        child: Card(
          child: ListTile(
            minLeadingWidth: 5,
            leading: InkWell(
              onTap: () async {
                task.isCompeleted = 0;
                await cubitTasks.updateToDoTask(toDoTask: task);
              },
              child: const Icon(
                FontAwesomeIcons.circleCheck,
                size: 16,
              ),
            ),
            title: Text(
              task.title,
              style: AppStyles.textStyleSemiBold20(context)
                  .copyWith(decoration: TextDecoration.lineThrough),
            ),
            subtitle: Text(
              task.date,
              style: AppStyles.textStyleRegular14(context),
            ),
          ),
        ),
      ),
    );
  }
}
