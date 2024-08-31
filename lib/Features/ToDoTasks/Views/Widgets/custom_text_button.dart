import 'package:flutter/material.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.isActive,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Text(
      transation(context).save,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isActive ? AppColors.blueColor : AppColors.greyColor,
      ),
    );
  }
}
