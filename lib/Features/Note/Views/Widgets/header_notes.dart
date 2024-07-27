import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Widgets/custom_text_form_field.dart';

class HeaderNotes extends StatelessWidget {
  const HeaderNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: AppStyles.textStyleExtraBold30,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          labelStyle: AppStyles.textStyleRegulard20,
          lable: 'Search Notes',
          preFixIcon: const Icon(Icons.search),
          enableBorder: setborderColor(AppColors.backgroundBottomBar),
          focusedBorder: setborderColor(AppColors.greenColor),
        )
      ],
    );
  }

  //const
  OutlineInputBorder setborderColor(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
