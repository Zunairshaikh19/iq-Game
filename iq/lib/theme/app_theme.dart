import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/constants/constants.dart';

ThemeData apptheme() {
  return ThemeData(
    hintColor: Colors.grey,
    brightness: Brightness.light,
    focusColor: AppColors.accent,
    fontFamily: AppStrings.font,
    primaryColor: AppColors.primary1,
    dividerColor: AppColors.textSecondary,
    visualDensity: VisualDensity.comfortable,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),
    textTheme:  const TextTheme(
      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontFamily: AppStrings.font,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontSize: 17,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 16.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 15.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 14.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 14.5,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14.5,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w500,
      ),
    ),
    primaryTextTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontFamily: AppStrings.font,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontSize: 17,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 16.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 15.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 15,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 14.5,
        fontFamily: AppStrings.font,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 14.5,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14.5,
        color: Colors.black,
        fontFamily: AppStrings.font,
        fontWeight: FontWeight.w500,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppDecorations.buildMaterialColor(AppColors.primary),
      brightness: Brightness.light,
      errorColor: AppColors.primary1,
    ).copyWith(secondary: AppColors.primary1),
  );
}
