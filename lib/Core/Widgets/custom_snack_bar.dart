import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';

void customSnackBar(
  context, {
  required String nameTask,
  AnimatedSnackBarType type = AnimatedSnackBarType.warning,
}) {
  final String message = _sendMessage(context, type);
  AnimatedSnackBar.rectangle(nameTask, message,
          type: type,
          brightness: Brightness.dark,
          duration: const Duration(seconds: 4))
      .show(context);
}

String _sendMessage(context, AnimatedSnackBarType type) {
  switch (type.index) {
    case 1:
      return transation(context).task_error;
    case 2:
      return transation(context).task_success;
    case 3:
      return transation(context).task_warnning;
    default:
      return transation(context).task_error_app;
  }
}
