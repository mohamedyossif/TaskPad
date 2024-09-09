import 'package:flutter/material.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';
import 'package:task_pad/Core/Utils/app_border_styles.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Widgets/custom_text_form_field.dart';

class AddToDoTaskForm extends StatelessWidget {
  const AddToDoTaskForm({
    super.key,
    required this.taskTitleController,
    required this.changeButtonColor,
  });

  final TextEditingController taskTitleController;
  final ValueNotifier<bool> changeButtonColor;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textEditingController: taskTitleController,
      onChanged: (value) {
        //check if user write task or no to change TextButtonColor

        if (value.isNotEmpty) {
          changeButtonColor.value = true;
          taskTitleController.text = value;
        } else {
          changeButtonColor.value = false;
        }
      },
      fillColor: AppColors.backgroundFormToDoColor,
      isFilled: true,
      maxLines: 5,
      minLines: 1,
      contentPadding: const EdgeInsets.only(left: 10),
      hint: transation(context).add_item,
      border: AppBorderStyles.outLineborderColorRadius(borderRadius: 12),
      enableBorder: AppBorderStyles.outLineborderColorRadius(borderRadius: 12),
      focusedBorder: AppBorderStyles.outLineborderColorRadius(borderRadius: 12),
    );
  }
}
