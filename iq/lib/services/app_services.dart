import 'package:get/get.dart';

import '/controllers/app_controller.dart';
import '/global/refs.dart';
import '/model/app_model.dart';
import '/model/categories.dart';
import '/model/challenges.dart';
import '/controllers/dashboard_controller.dart';
import '../constants/constants.dart';
import '../model/games.dart';
import '../model/questionair.dart';

class AppServices extends GetxService {
  final DashboardController dashboard = Get.put(DashboardController());
  final AppController controller = Get.put(AppController());

  Future<AppServices> init() async {
    await controller.fetchData();
    return this;
  }

  AppSupport get support => controller.support.value;
  Categories get appcategories => controller.categories.value;
  Games get games => controller.game.value;
  Questionair get questionair => controller.questionair.value;
  Challenges get challenge => controller.challenge.value;
  AboutModel get about => controller.about.value;

  List<AppModel> get categories => appcategories.categories ?? <AppModel>[];

  increaseUsers() async {
    controller.support.value.users = controller.support.value.users! + 1;
    await utilsRef.doc(AppStrings.support).update({'users': support.users});
  }

  increasePremium() async {
    controller.support.value.premium = controller.support.value.premium! + 1;
    await utilsRef.doc(AppStrings.support).update({'premium': support.premium});
  }

  increaseRequests() async {
    controller.support.value.requests = controller.support.value.requests! + 1;
    await utilsRef
        .doc(AppStrings.support)
        .update({'requests': support.requests});
  }
}
