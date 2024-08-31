import 'dart:developer';

import 'package:flutter/material.dart';

class Sizeconfig {
  static double height(context) => MediaQuery.sizeOf(context).height;
  static double width(context) => MediaQuery.sizeOf(context).width;
  static const tablet = 800;
  static const desktop = 1300;
  static double getfontsize(context, {required double fontSize}) {
    var factorScalor = _getScalarFactor(context);
    var responsiveFont = factorScalor * fontSize;
    var lowerLimit = responsiveFont * 0.8;
    var upperLimit = responsiveFont * 1.2;
    print(
        "resonsive font $responsiveFont  lowerLimit $lowerLimit  upperLimit $upperLimit  final ${responsiveFont.clamp(lowerLimit, upperLimit)}");
    return responsiveFont.clamp(lowerLimit, upperLimit);
  }

  static double _getScalarFactor(context) {
    // var dispatcher = PlatformDispatcher.instance;
    // var phyiscsWidth = dispatcher.views.first.physicalSize.width;
    // var devicalRadio = dispatcher.views.first.devicePixelRatio;
    // double constraints = phyiscsWidth / devicalRadio;
    double constraints = MediaQuery.sizeOf(context).width;
    log(constraints.toString());
    if (constraints < tablet) {
      return constraints / 430;
    } else if (constraints < desktop) {
      return constraints / 900;
    } else {
      return constraints / 1530;
    }
  }
}
