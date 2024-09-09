import 'package:flutter/material.dart';

Future<void> customAlertDialog(BuildContext context,
    {required String title,
    required String subtitle,
    required String button1Name,
    required String button2Name,
    ontap1,
    ontap2}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          TextButton(
            child: Text(button1Name),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(onPressed: ontap2, child: Text(button2Name)),
        ],
      );
    },
  );
}

// void openAppSettings() async {
//   const intent = AndroidIntent(
//     action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
//     data: 'package:com.example.task_pad',
//     flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//   );
//   await intent.launch();
// }
