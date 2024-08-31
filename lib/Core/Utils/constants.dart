import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double kPaddingScreen = 12;

///Database tables
const kNameTableNotes = 'note';

///database comman varibale
const kTitle = 'title';
const kDate = 'date';
const kId = 'id';

//database vairable table note
const kSubtitleNote = 'subtitle';

//database vairable table to-do
const kNameTableToDoTask = 'ToDoTask';
const kTaskIsCompeleted = 'IsCompeleted';
// laguages
final languages = ['Ar', 'En'];

///format date
String kFormatDate = 'd MMMM yyyy h:mm a';
final DateFormat arabicDateFormat = DateFormat(kFormatDate, 'ar');

///glocal
// need to perform navigation or other context-based operations from outside the usual widget tree

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
