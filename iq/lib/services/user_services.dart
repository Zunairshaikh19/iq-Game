import 'package:get/get.dart';
import 'package:iq/backend/firebase_auth.dart';

import '/controllers/user_controller.dart';
import '/model/settings.dart';
import '/model/subscriptions.dart';
import '/model/users.dart';

class UserServices extends GetxService {
  final UserController controller = Get.put(UserController());

  Future<UserServices> init() async {
    await controller.checkUserLogin().then((value) async {
      if (value) {
        await controller.fetchData(userid);
      } else {
        await signInAnonymously();
      }
    });
    return this;
  }

  UserModel get user => controller.user.value;
  SettingsModel get settings => controller.settings.value;
  Subscriptions get subscriptions => controller.subscriptions.value;

  bool get isAuth => controller.isAuth.value;
  bool get subscription => user.premium ?? false;
  bool get premium => controller.isAuth.value && subscription;
  bool get anonymous => user.anonymous ?? false;

  String get userid => user.id ?? '';

  List<String> get favQuestions => controller.favQuestions;
  bool isFavQuestion(String id) => favQuestions.contains(id);
}
