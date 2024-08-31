import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_pad/Core/Utils/app_border_styles.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Widgets/custom_text_form_field.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch(
      {super.key, required this.hint, this.searchController, this.onChanged});
  final String hint;
  final TextEditingController? searchController;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: CustomTextFormField(
        onChanged: onChanged,
        textEditingController: searchController,
        labelStyle: AppStyles.textStyleRegulard16(context),
        contentPadding: const EdgeInsets.only(left: 10),
        lable: hint,
        preFixIcon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 15,
        ),
        enableBorder: AppBorderStyles.outLineborderColorRadius(
            borderColor: AppColors.whiteColor.withOpacity(0.2),
            borderRadius: 20),
        focusedBorder: AppBorderStyles.outLineborderColorRadius(
            borderColor: AppColors.whiteColor.withOpacity(0.5),
            borderRadius: 20),
      ),
    );
  }
}
