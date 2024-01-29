import 'package:flutter/material.dart';

import '/constants/constants.dart';

outlineButton({
  Color? primary = AppColors.accent,
  Color? surface = AppColors.accent,
  Color? borderColor = AppColors.accent,
  double? radius = 10.0,
  double? elevation,
  double width = 1.0,
}) {
  return OutlinedButton.styleFrom(
    foregroundColor: primary ?? AppColors.accent,
    elevation: elevation,
    disabledForegroundColor: surface!.withOpacity(0.38),
    shadowColor: Colors.transparent,
    side: BorderSide(color: borderColor!, width: width),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}

elevatedButton({
  required Color primary,
  Color? surface = AppColors.text,
  required Color? borderColor,
  Color onPrimary = AppColors.text,
  double? radius = 10.0,
  Color? shadowColor,
  double? elevation,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: onPrimary,
    backgroundColor: primary,
    disabledForegroundColor: surface!.withOpacity(0.38),
    disabledBackgroundColor: surface.withOpacity(0.12),
    elevation: elevation,
    shadowColor: shadowColor,
    side: BorderSide(color: borderColor!),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}
