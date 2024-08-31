import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/size_config.dart';

class AppStyles {
//
  static textStyleExtraBold28(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 28),
        letterSpacing: 1,
        fontWeight: FontWeight.w800,
      );
  static textStyleRegulard20(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 20),
        color: Colors.white.withOpacity(0.5),
      );
  static textStyleRegulard16(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 16),
        color: Colors.white.withOpacity(0.6),
      );
  static textStyleSemiBold20(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 20),
        fontWeight: FontWeight.w500,
      );
  static textStyleExtraBold35(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 35),
        letterSpacing: 2,
        fontWeight: FontWeight.w800,
      );
  static textStyleRegular14(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 14),
        color: Colors.white.withOpacity(0.3),
      );
  static textStyleSemiBold25(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 25),
        fontWeight: FontWeight.w600,
      );
  static textStyledefault22(context) => TextStyle(
        fontSize: Sizeconfig.getfontsize(context, fontSize: 22),
      );
  //non

// borders
}
