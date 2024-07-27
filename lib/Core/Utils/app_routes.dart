import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Features/Note/Views/edit_note_view.dart';
import 'package:task_pad/Features/Splash/Views/splash_view.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Views/home_task_pad_view.dart';

class AppRoutes {
  static const homeTaskPadView = '/homeTaskPadView';
  static const editNoteView = '/editNoteView';

  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: editNoteView,
        builder: (context, state) => const EditNoteView(),
      ),
      GoRoute(
        path: homeTaskPadView,
        builder: (context, state) => BlocProvider(
          create: (context) => BottomNavBarCubit(),
          child: const HomeTaskPadView(),
        ),
      )
    ],
  );
}
