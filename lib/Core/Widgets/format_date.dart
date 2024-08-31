import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/app_utils.dart';

class CustomFormatDate extends StatelessWidget {
  const CustomFormatDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(AppUtils.formatDate(context),
        style: AppStyles.textStyleRegular14(context));
  }
}
