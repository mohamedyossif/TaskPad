import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Utils/app_assets.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/helper/dataBase/cache_helper.dart';
import 'package:task_pad/Features/OnBoarding/Views/widgets/customPageView.dart';

import '../../../Core/Widgets/custom_alert_dialog.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  void _onIntroEnd(BuildContext context) async {
    await customAlertDialog(context,
        title: transation(context).battery_title,
        subtitle: transation(context).battery_subtitle,
        button1Name: transation(context).later,
        button2Name: transation(context).disable,
        ontap1: () => Navigator.of(context).pop(),
        ontap2: () {
          openAppSettings();
          Navigator.of(context).pop();
        }).then((x) {
      CacheHelper.setOnboarding(true).then(
        (value) => context.pushReplacement(AppRoutes.homeTaskPadView),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            pageViewModel(
                index: 0,
                context: context,
                images: AppAssets.imagesOnboardingNote,
                title: transation(context).onBoarding_one_image),
            pageViewModel(
                index: 1,
                context: context,
                images: AppAssets.imagesOnboardingTask,
                title: transation(context).onBoarding_two_image),
            pageViewModel(
                index: 2,
                context: context,
                images: AppAssets.imagesOnboardingNotification,
                title: transation(context).onBoarding_three_image),
          ],
          showSkipButton: true,
          skip: Text(
            transation(context).skip,
            style: AppStyles.textStyledefault22(context).copyWith(
              color: AppColors.blueColor,
            ),
          ),
          next: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.blueColor,
          ),
          done: Text(transation(context).done,
              style: AppStyles.textStyledefault22(context).copyWith(
                  color: AppColors.blueColor, fontWeight: FontWeight.w700)),
          onDone: () {
            _onIntroEnd(context);
          },
          onSkip: () {
            _onIntroEnd(context);
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(25.0, 10.0),
            activeColor: AppColors.blueColor,
            color: const Color(0xffBBBDBB),
            spacing: const EdgeInsets.symmetric(horizontal: 5.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
