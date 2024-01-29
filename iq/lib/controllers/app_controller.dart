import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/age_group.dart';
import '/backend/cloud_firestore.dart';
import '../constants/constants.dart';
import '../global/refs.dart';
import '../model/app_model.dart';
import '../model/categories.dart';
import '../model/challenges.dart';
import '../model/games.dart';
import '../model/questionair.dart';

class AppController extends GetxController {
  Rx<Categories> categories = Categories().obs;
  Rx<AppSupport> support = AppSupport().obs;
  Rx<Games> game = Games(search: [], designedto: '', ageGroup: []).obs;
  Rx<Challenges> challenge = Challenges().obs;
  Rx<Questionair> questionair = Questionair().obs;
  Rx<AboutModel> about = AboutModel().obs;
   Rx<AgeGroup> agegroup = AgeGroup().obs;

  getAbout() async {
    await utilsRef.doc(AppStrings.about).get().then((value) {
      if (value.data() != null) {
        about.value = AboutModel.fromMap(value.data());
      }
    });
  }

  getSamples() async {
    await utilsRef.doc(AppStrings.sampleGame).get().then((value) {
      if (value.data() != null) {
        game.value = Games.fromMap(value.data());
      }
    });
    await utilsRef.doc(AppStrings.sampleChallenge).get().then((value) {
      if (value.data() != null) {
        challenge.value = Challenges.fromMap(value.data());
      }
    });
    await utilsRef.doc(AppStrings.sampleQuestionair).get().then((value) {
      if (value.data() != null) {
        questionair.value = Questionair.fromMap(value.data());
      }
    });
  }

  getSupport() async {
    await utilsRef.doc(AppStrings.support).get().then((value) {
      if (value.data() != null) {
        support.value = AppSupport.fromMap(value.data());
      }
    });
  }

  getCategories() async {
    await utilsRef.doc(AppStrings.categories).get().then((value) {
      if (value.data() != null) {
        categories.value = Categories.fromMap(value.data());
      }
    });
     await utilsRef.doc(AppStrings.ageGroup).get().then((value) {
      if (value.data() != null) {
        agegroup.value = AgeGroup.fromMap(value.data());
      }
    });
  }

  fetchData() async {
    try {
      await getSupport();
      await getSamples();
      await getCategories();
      await getAbout();
    } catch (e) {
      debugPrint('App Controller Error: $e');
      throw Exception(e);
    }
  }

  @override
  void onInit() {
    addVisit();
    super.onInit();
  }
}
