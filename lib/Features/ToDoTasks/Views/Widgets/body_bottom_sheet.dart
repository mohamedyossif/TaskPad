import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';
import 'package:task_pad/Core/Utils/app_utils.dart';
import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/Widgets/custom_snack_bar.dart';
import 'package:task_pad/Core/helper/local_notification.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/add_to_do_task_form.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_date_and_time_picker.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_text_button.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class BodyBottomSheet extends StatefulWidget {
  const BodyBottomSheet({
    super.key,
    this.taskModel,
  });
  final ToDoTaskModel? taskModel;
  @override
  State<BodyBottomSheet> createState() => _BodyBottomSheetState();
}

class _BodyBottomSheetState extends State<BodyBottomSheet> {
  //custom Conrtoller
  final ValueNotifier<bool> changeButtonColor = ValueNotifier(false);
  late TextEditingController taskTitleController = TextEditingController();
  late ToDoTasksCubit cubitTasks;
  @override
  void initState() {
    cubitTasks = BlocProvider.of<ToDoTasksCubit>(context);
    if (widget.taskModel != null) {
      taskTitleController.text = widget.taskModel!.title;
      cubitTasks.dateTimeEntered = widget.taskModel!.date;
    }
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    changeButtonColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          // keyboard height
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingScreen, horizontal: kPaddingScreen),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddToDoTaskForm(
              taskTitleController: taskTitleController,
              changeButtonColor: changeButtonColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomDateAndTimeButtonSection(
                  toDoTaskModel: widget.taskModel,
                ),
                const Spacer(),
                InkWell(
                  onTap: ontap,
                  child: ValueListenableBuilder(
                    valueListenable: changeButtonColor,
                    builder: (context, state, child) {
                      return CustomTextButton(
                        isActive: state,
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void ontap() async {
    // check if taskmodel is not null then we are in editting task
    // check title is not empty before editting task
    if (widget.taskModel != null && taskTitleController.text.isNotEmpty) {
      await updateTask(cubitTasks, context);
    } else {
      // check if taskmodel is  null then we are in adding task
      await checkAndInsertTask(cubitTasks);
    }
    // clear data
    taskTitleController.clear();
    // remove old date
    cubitTasks.dateTimeEntered = null;
    //check widget is exist or not
    if (mounted) {
      context.pop();
    }
  }

  Future<void> updateTask(
      ToDoTasksCubit cubitTasks, BuildContext context) async {
    ToDoTaskModel task = ToDoTaskModel(
      title: taskTitleController.text,
      date: cubitTasks.dateTimeEntered!,
      id: widget.taskModel!.id,
      isCompeleted: widget.taskModel!.isCompeleted,
    );

    await cubitTasks.updateToDoTask(toDoTask: task);
    //check user change date to chnage notification Date
    if (cubitTasks.dateTimeEntered != widget.taskModel!.date &&
        task.isCompeleted == 0) {
      await setNotification(task);
    }
  }

  // if user add task
  Future<void> checkAndInsertTask(ToDoTasksCubit cubitTasks) async {
    // check title is not empty before add task
    String selectedDate =
        cubitTasks.dateTimeEntered ?? AppUtils.formatDate(context);
    ToDoTaskModel task =
        ToDoTaskModel(title: taskTitleController.text, date: selectedDate);
    if (taskTitleController.text.isNotEmpty) {
      int id = await cubitTasks.insertToDoTask(toDoTask: task);
      task.id = id;
      await setNotification(task);
    }
  }

  Future<void> setNotification(ToDoTaskModel task) async {
    //Stored Date
    DateTime date = AppUtils.stringToDateTime(context, task.date);
    //current Date
    DateTime dateNow = DateTime.now();
    DateTime currentDate = DateTime(
        dateNow.year, dateNow.month, dateNow.day, dateNow.hour, dateNow.minute);
    //check user put Future date
    if (date.isAfter(currentDate)) {
      String message = transation(context).message_task;
      //set notifcation
      LocalNotification.scheduleNotification(task, date, message);
    } else if (date.isAtSameMomentAs(currentDate)) {
      customSnackBar(context, nameTask: task.title);
    } else {
      customSnackBar(context,
          type: AnimatedSnackBarType.error, nameTask: task.title);
    }
  }
}
