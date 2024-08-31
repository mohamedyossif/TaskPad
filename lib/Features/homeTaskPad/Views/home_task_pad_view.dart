import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/custom_bottom_nav_bar.dart';
import 'package:task_pad/Features/Note/Views/notes_view.dart';
import 'package:task_pad/Features/ToDoTasks/Views/to_do_view.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/open_bottom_sheet.dart';

class HomeTaskPadView extends StatelessWidget {
  const HomeTaskPadView({
    super.key,
  });
  // screens
  final List screens = const [NotesView(), ToDoView()];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          // body
          body: screens[state],
          //loacation button
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          //float button
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.blueColor,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () async {
              // check screen add note or to-do
              if (context.mounted) {
                state == 0
                    ? context.push(
                        AppRoutes.editNoteView,
                      )
                    : openBottomSheet(context, null);
              }
            },
            child: const Icon(Icons.add, size: 35),
          ),
          // button navigator bar
          bottomNavigationBar: CustomBottomNavBar(currentIndex: state),
        ),
      );
    });
  }
}
