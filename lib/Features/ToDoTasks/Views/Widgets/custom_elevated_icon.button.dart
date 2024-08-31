import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton({
    super.key,
    this.onPressed,
    required this.labe,
  });
  final void Function()? onPressed;
  final String labe;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: AppColors.backgroundFormToDoColor,
            iconColor: AppColors.whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        label: Text(
          labe,
          style: AppStyles.textStyleRegular14(context)
              .copyWith(color: AppColors.whiteColor),
        ),
        icon: const Icon(
          Icons.alarm,
          size: 16,
        ),
        onPressed: onPressed);
  }
}
