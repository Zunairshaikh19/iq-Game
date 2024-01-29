// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class Ui {
  static GetSnackBar SuccessSnackBar({
    String title = 'Success',
    required String message,
  }) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          const TextStyle(color: Colors.white, fontFamily: AppStrings.font),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall?.merge(
          const TextStyle(color: Colors.white, fontFamily: AppStrings.font),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'Error', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          const TextStyle(color: Colors.white, fontFamily: AppStrings.font),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall!.merge(
          const TextStyle(color: Colors.white, fontFamily: AppStrings.font),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(
        Icons.remove_circle_outline,
        size: 32,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar(
      {String title = 'Notification', required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(
            color: Get.theme.hintColor,
          ),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodySmall!.merge(
          TextStyle(
            color: Get.theme.focusColor,
          ),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(
        Icons.notifications_none,
        size: 32,
        color: Get.theme.hintColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double opacity = 1}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  static List<Icon> getStarsList(
    double rate, {
    double size = 18,
    Color color = const Color(0xFFFFB24D),
  }) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: color);
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: color));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star, size: size, color: const Color(0xffE3E5E6));
    }));
    return list;
  }
}
