import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_pad/Core/Utils/constants.dart';

class AppUtils {
  static String formatDate(context, {DateTime? dateTime}) {
    return DateFormat(kFormatDate, Localizations.localeOf(context).languageCode)
        .format(dateTime ?? DateTime.now());
  }

  //note should pattern used in parsing(kFormatDate) matchs with data(formattedDate) which you want to convert it
  // parsed Data will be in default pattern (yyyy-MM-dd h:mm a)
  static DateTime stringToDateTime(BuildContext context, String formattedDate) {
    return DateFormat(kFormatDate, Localizations.localeOf(context).languageCode)
        .parse(formattedDate);
  }
}
