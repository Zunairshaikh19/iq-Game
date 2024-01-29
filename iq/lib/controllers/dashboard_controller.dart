import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  ScrollController controller = ScrollController();

  scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      Get.log('bottom');
    }
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {
      Get.log('top');
    }
  }

  @override
  void onInit() {
    controller.addListener(scrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
