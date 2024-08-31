import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:task_pad/Features/Note/Views/add_and_edit_note_view.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';
import 'package:task_pad/Features/OnBoarding/Views/onboarding_view.dart';
import 'package:task_pad/Features/Splash/Views/splash_view.dart';
import 'package:task_pad/Features/homeTaskPad/Views/home_task_pad_view.dart';

class AppRoutes {
  static const homeTaskPadView = '/homeTaskPadView';
  static const editNoteView = '/editNoteView';
  static const onboarding = '/onboarding';

  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
          path: editNoteView,
          builder: (context, state) {
            return AddAndEditNoteView(
              receivedNote:
                  state.extra == null ? null : state.extra as NoteModel,
            );
          }),
      GoRoute(
          path: homeTaskPadView,
          builder: (context, state) {
            log(state.extra.toString());
            return HomeTaskPadView(
              x: state.extra == null ? null : 1,
            );
          }),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingView(),
      )
    ],
  );
}
