import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';

void main() {
  runApp(const TaskPadApp());
}

class TaskPadApp extends StatelessWidget {
  const TaskPadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Tajawal',
        brightness: Brightness.dark,
      ),
      routerConfig: AppRoutes.routes,
    );
  }
}
