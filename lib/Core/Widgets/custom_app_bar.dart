import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Widgets/custom_search.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/custom_pop_button_menu.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.hintTextField,
    this.searchController,
    this.onChanged,
    required this.indexBottomNav,
  });
  final String title, hintTextField;
  final TextEditingController? searchController;
  final Function(String)? onChanged;
  final int indexBottomNav;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: AppStyles.textStyleExtraBold28(context)),
            const Spacer(),
            CustomPopButtonMenu(
              deleteName: title,
              indexDelete: indexBottomNav,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomSearch(
          onChanged: onChanged,
          searchController: searchController,
          hint: hintTextField,
        ),
      ],
    );
  }
}
