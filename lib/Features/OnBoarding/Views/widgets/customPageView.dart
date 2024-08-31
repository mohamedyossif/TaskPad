import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/size_config.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/language_alert_dialog.dart';

PageViewModel pageViewModel(
    {required String title,
    required String images,
    required int index,
    required BuildContext context}) {
  return PageViewModel(
    useScrollView: false,
    title: index == 0 ? null : "",
    titleWidget: index == 0
        ? Align(
            alignment: Localizations.localeOf(context).languageCode == 'en'
                ? Alignment.topRight
                : Alignment.topLeft,
            child: TextButton.icon(
              onPressed: () {
                languageAlertDialog(context);
              },
              icon: const Icon(
                Icons.language,
                color: AppColors.whiteColor,
              ),
              label: Text(
                Localizations.localeOf(context).languageCode == 'en'
                    ? transation(context).en
                    : transation(context).ar,
                style: AppStyles.textStyledefault22(context),
              ),
            ))
        : null,
    bodyWidget: Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: Sizeconfig.width(context) * 0.6,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: SvgPicture.asset(
                images,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.textStyledefault22(context).copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    ),
  );
}
