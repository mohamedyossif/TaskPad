import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Views/Widgets/custom_bottom_nav_bar.dart';
import 'package:task_pad/Features/Note/Views/notes_view.dart';
import 'package:task_pad/Features/homeTaskPad/Views/to_do_view.dart';

class HomeTaskPadView extends StatelessWidget {
  const HomeTaskPadView({super.key});

  @override
  Widget build(BuildContext context) {
    // screens
    const List screens = [NotesView(), ToDoView()];
    return BlocConsumer<BottomNavBarCubit, int>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child: Scaffold(
            // body
            body: screens[state],
            //loacation button
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            //float button
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.greenColor,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              onPressed: () {},
              child: const Icon(Icons.add, size: 35),
            ),
            // button navigator bar
            bottomNavigationBar: CustomBottomNavBar(currentIndex: state)),
      ),
    );
  }
}
