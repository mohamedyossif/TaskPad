import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.enableBorder,
    this.focusedBorder,
    this.isFilled,
    this.lable,
    this.hint,
    this.fillColor,
    this.preFixIcon,
    this.labelStyle,
    this.hintStyle,
    this.linesMax,
  });
  final InputBorder? enableBorder, focusedBorder;
  final bool? isFilled;
  final String? lable, hint;
  final Color? fillColor;
  final Widget? preFixIcon;
  final TextStyle? labelStyle, hintStyle;
  final int? linesMax;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: lable,
        hintMaxLines: linesMax,
        hintText: hint,
        prefixIcon: preFixIcon,
        filled: isFilled,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        fillColor: fillColor,
        focusedBorder: focusedBorder,
        enabledBorder: enableBorder,
      ),
    );
  }
}
