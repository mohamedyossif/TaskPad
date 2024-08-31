import 'package:flutter/material.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Widgets/custom_list_title.dart';
import 'package:task_pad/Core/helper/dataBase/cache_helper.dart';
import 'package:task_pad/main.dart';

void languageAlertDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(transation(context).select_lang),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTitle(
              title: transation(context).en,
              onTap: () async {
                TaskPadApp.setLocate(context, const Locale('en'));
                await CacheHelper.setLanguage('en')
                    .then((value) => Navigator.of(context).pop());
              },
            ),
            CustomListTitle(
              title: transation(context).ar,
              onTap: () async {
                TaskPadApp.setLocate(context, const Locale('ar'));
                await CacheHelper.setLanguage('ar')
                    .then((value) => Navigator.of(context).pop());
              },
            ),
          ],
        ),
      );
    },
  );
}
