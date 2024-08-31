import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/helper/dataBase/cache_helper.dart';
import 'package:task_pad/Core/helper/local_notification.dart';
import 'package:task_pad/Core/helper/work_manager_notification.dart';
import 'package:task_pad/Features/Note/Cubits/NotesCubit/notes_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalNotification.initialLocalNotification(),
    WorkManagerNotification.init(),
  ]);
  runApp(const TaskPadApp());
}

class TaskPadApp extends StatefulWidget {
  const TaskPadApp({super.key});
  static void setLocate(BuildContext context, Locale newLocal) {
    // to search about _TaskPadAppState in widget tree
    _TaskPadAppState? state =
        context.findAncestorStateOfType<_TaskPadAppState>();
    state?.changeLanguage(newLocal);
  }

  @override
  State<TaskPadApp> createState() => _TaskPadAppState();
}

class _TaskPadAppState extends State<TaskPadApp> {
  Locale _localeApp = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _localeApp = locale;
    });
  }

  @override
  void didChangeDependencies() {
    log("did chanage");
    CacheHelper.getLanguage().then((value) => changeLanguage(value));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log("Media ${MediaQuery.sizeOf(context).width}");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => NotesCubit()..getAllNotes(),
        ),
        BlocProvider(
          create: (context) => ToDoTasksCubit()..getAllTasks(),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _localeApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'cairo',
              ),
        ),
        routerConfig: AppRoutes.routes,
      ),
    );
  }
}
