import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_assets.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/size_config.dart';

class CustomNoData extends StatelessWidget {
  const CustomNoData({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Sizeconfig.width(context) * 0.8,
          child: AspectRatio(
            aspectRatio: 8 / 2,
            child: Image.asset(
              AppAssets.imagesNotFounded,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          message,
          style: AppStyles.textStyleRegulard20(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
