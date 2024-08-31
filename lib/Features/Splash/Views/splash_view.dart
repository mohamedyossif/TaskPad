import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Utils/app_assets.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/size_config.dart';
import 'package:task_pad/Core/helper/dataBase/cache_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // schedules the provided callback to be executed after the current frame is rendered.
    // This ensures that the widget tree is fully built and the context is valid for navigation
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigatorTo();
    });
    super.initState();
  }

  void navigatorTo() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      CacheHelper.getOnboarding().then((value) {
        if (value) {
          context.pushReplacement(AppRoutes.homeTaskPadView, extra: null);
        } else {
          context.pushReplacement((AppRoutes.onboarding));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Sizeconfig.width(context) * 0.4,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  AppAssets.imagesLogoApp,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('TaskPad', style: AppStyles.textStyleExtraBold35(context)),
          ],
        ),
      ),
    );
  }
}
