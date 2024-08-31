import 'package:flutter/material.dart';

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
    this.border,
    this.keyboardType,
    this.isExpand,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.textStyleData,
    this.textEditingController,
    this.validator,
    this.onChanged,
    this.onSaved,
  });
  final InputBorder? enableBorder, focusedBorder, border;
  final bool? isFilled;
  final String? lable, hint;
  final Color? fillColor;
  final Widget? preFixIcon;
  final TextStyle? labelStyle, hintStyle;
  final int? maxLines, minLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool? isExpand;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyleData;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChanged,
      controller: textEditingController,
      style: textStyleData,
      keyboardType: keyboardType,
      expands: isExpand ?? false,
      maxLines: maxLines,
      validator: validator,
      minLines: minLines,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.zero,
        labelText: lable,
        hintText: hint,
        prefixIcon: preFixIcon,
        filled: isFilled,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        fillColor: fillColor,
        enabled: true,
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: enableBorder,
      ),
    );
  }
}
