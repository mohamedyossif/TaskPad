import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';
import 'package:task_pad/Core/Widgets/custom_alert_dialog.dart';
import 'package:task_pad/Core/Notification/local_notification.dart';
import 'package:task_pad/Features/Note/Cubits/NotesCubit/notes_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/language_alert_dialog.dart';

class CustomPopButtonMenu extends StatelessWidget {
  const CustomPopButtonMenu(
      {super.key, required this.deleteName, required this.indexDelete});
  final String deleteName;
  final int indexDelete;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (int result) async {
        if (result == 1) {
          languageAlertDialog(context);
        } else if (result == 2) {
          await openAppSettings();
        } else {
          customAlertDialog(context,
              title: '${transation(context).delete_all} $deleteName',
              subtitle: transation(context).subtitle_delete,
              button2Name: transation(context).delete,
              button1Name: transation(context).cancel, ontap2: () {
            //user want to delete all notes
            if (indexDelete == 0) {
              var cubitNote = BlocProvider.of<NotesCubit>(context);
              // check if no notes
              cubitNote.notes.isEmpty ? "" : cubitNote.deleteAll();
            } else {
              //user want to delete all Tasks
              var cubitTask = BlocProvider.of<ToDoTasksCubit>(context);
              // check if no tasks and remove notification
              if (cubitTask.allTasks.isNotEmpty) {
                cubitTask.deleteAll().then(
                      (x) => LocalNotification.cancelAllNotifications(),
                    );
              }
            }
            Navigator.of(context).pop();
          });
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language,
              ),
              const SizedBox(width: 15),
              Text(transation(context).lang),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.notifications,
              ),
              const SizedBox(width: 15),
              Text(transation(context).notification_alert),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              const SizedBox(width: 15),
              Text(transation(context).delete_all),
            ],
          ),
        ),
      ],
    );
  }
}
