import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '/backend/cloud_firestore.dart';
import '/global/refs.dart';
import '/model/settings.dart';
import '/model/subscriptions.dart';
import '/model/users.dart';

class UserController extends GetxController {
  final RxBool isAuth = false.obs;
  Rx<UserModel> user = UserModel().obs;
  Rx<SettingsModel> settings = SettingsModel().obs;
  Rx<Subscriptions> subscriptions = Subscriptions().obs;

  Future<bool> checkUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuth.value = prefs.getBool(AppStrings.isLogin) ?? false;
    if (isAuth.value) {
      String userid = prefs.getString(AppStrings.userid) ?? '';
      await getUserData(userid);
      return true;
    } else {
      return false;
    }
  }

  getUserData(String id) async {
    await userRef.doc(id).get().then((value) async {
      user.value = UserModel.fromMap(value.data());
      await getSettings(id);
      if (user.value.premium!) getSubscription(id);
    });
  }

  getSettings(String id) async {
    await settingsRef.doc(id).get().then((value) async {
      if (value.data() == null) {
        settings.value = SettingsModel(
          id: id,
          token: '',
          active: true,
          last: DateTime.now(),
          notifications: true,
        );
        await settingsRef.doc(id).set(settings.value.toMap());
      } else {
        settings.value = SettingsModel.fromMap(value.data());
      }
    });
  }

  getSubscription(String id) async {
    await subscriptionRef.doc(id).get().then((value) {
      subscriptions.value = Subscriptions.fromMap(value.data());
    });
  }

  clearData() async {
    userStatus(user.value.id!, false);
    isAuth.value = false;
    user.value = UserModel();
    settings.value = SettingsModel();
    subscriptions.value = Subscriptions();
    favQuestions.clear();
  }

  @override
  void dispose() {
    if (isAuth.value) userStatus(user.value.id ?? '', false);
    super.dispose();
  }

  RxList<String> favQuestions = <String>[].obs;
  fetchFavQuestions(String userid) async {
    favQuestions.clear();
    await favoriteQuestions(userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          favQuestions.add(doc.id);
        }
      }
    });
  }

  fetchData(String userid) async {
    try {
      await fetchFavQuestions(userid);
    } catch (e) {
      debugPrint('User Data: $e');
      throw Exception(e);
    }
  }
}
