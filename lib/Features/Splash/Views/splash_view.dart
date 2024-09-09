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

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0, end: 2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle));
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    // schedules the provided callback to be executed after the current frame is rendered.
    // This ensures that the widget tree is fully built and the context is valid for navigation
    _controller.forward().whenComplete(() => navigatorTo());

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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
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
        ),
      ),
    );
  }
}
