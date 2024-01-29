import 'package:flutter/material.dart';

import '/constants/constants.dart';

TextStyle inputStyle = const TextStyle(
  color: AppColors.accent,
  fontWeight: FontWeight.normal,
  fontFamily: AppStrings.font,
);

InputDecoration inputDecoration({
  Widget? icon,
  String? helper,
  String? hint,
  String? error,
  String? label,
  Widget? suffix,
  Widget? prefix,
  Color? filledColor,
  InputBorder? border,
  InputBorder? errorBorder,
  InputBorder? focusBorder,
  bool? filled = false,
  double radius = 4,
  bool? dense = true,
  double hintSize = 12,
  String? fontFamily = AppStrings.font,
  Color? errorColor = AppColors.accent,
  Color? hintColor = AppColors.borderColor,
  Color? focusColor = AppColors.borderColor,
  Color? labelColor = AppColors.borderColor,
  Color? helperColor = AppColors.borderColor,
  Color? borderColor = AppColors.borderColor,
  double labelsize = 14,
  FontWeight labelWeight = FontWeight.normal,
  FontWeight hintWeight = FontWeight.normal,
  EdgeInsetsGeometry? padding,
}) {
  return InputDecoration(
    icon: icon,
    hintText: hint,
    isDense: dense,
    filled: filled,
    errorText: error,
    labelText: label,
    helperText: helper,
    suffixIcon: suffix,
    prefixIcon: prefix,
    fillColor: filledColor,
    focusColor: AppColors.accent,
    contentPadding: padding ?? const EdgeInsets.all(15),
    helperStyle: TextStyle(
      color: helperColor,
      fontFamily: fontFamily,
      fontSize: hintSize,
      fontWeight: FontWeight.normal,
    ),
    errorStyle: TextStyle(
      color: errorColor,
      fontFamily: fontFamily,
      fontSize: hintSize,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: labelColor,
      fontFamily: fontFamily,
      fontSize: labelsize,
      fontWeight: labelWeight,
    ),
    hintStyle: TextStyle(
      color: hintColor,
      fontFamily: fontFamily,
      fontSize: hintSize,
      fontWeight: hintWeight,
    ),
    border: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    enabledBorder: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    focusedBorder: focusBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: focusColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    errorBorder: errorBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    focusedErrorBorder: errorBorder ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
    disabledBorder: border ??
        UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
  );
}

decoration({
  String? hint,
  String? label,
  Widget? suffix,
  Widget? prefix,
  double? radius,
  Color? color,
  double? width,
  bool? fill,
  Color? fillColor,
}) {
  return inputDecoration(
    hint: hint,
    label: label,
    suffix: suffix,
    prefix: prefix,
    filled: fill ?? false,
    filledColor: fillColor ?? Colors.grey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide:
          BorderSide(color: color ?? AppColors.borderColor, width: width ?? 1),
    ),
    focusBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide: BorderSide(color: AppColors.accent, width: width ?? 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 4.0),
      borderSide: BorderSide(color: AppColors.accent, width: width ?? 1),
    ),
  );
}
