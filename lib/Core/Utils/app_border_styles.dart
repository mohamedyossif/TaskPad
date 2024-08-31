import 'package:flutter/material.dart';

class AppBorderStyles {
  static OutlineInputBorder outLineborderColorRadius(
      {Color? borderColor, double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      borderSide: BorderSide(color: borderColor ?? Colors.transparent),
    );
  }
}
