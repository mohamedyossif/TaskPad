import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void customSnackBar(context, {required String nameTask}) {
  AnimatedSnackBar.rectangle(
    'Success',
    nameTask,
    type: AnimatedSnackBarType.success,
    brightness: Brightness.dark,
  ).show(context);
}
