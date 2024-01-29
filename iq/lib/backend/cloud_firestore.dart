import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/model/subscriptions.dart';
import 'package:iq/widgets/custom_dialogs.dart';

import '../model/questions.dart';
import '../widgets/loading_widgets.dart';
import '/controllers/user_controller.dart';
import '/global/refs.dart';
import '../constants/constants.dart';
import '../model/users.dart';

final UserController userController = Get.find();

userStatus(String userid, bool status) async {
  await settingsRef.doc(userid).update({
    'token': '',
    'active': status,
    if (status) 'last_active': DateTime.now()
  });
}

addVisit() async {
  await utilsRef
      .doc(AppStrings.support)
      .update({'visits': FieldValue.increment(1)});
}

addUser(UserModel user, String anonymous) async {
  await userRef.doc(user.id).set(user.toMap());
  if (anonymous != '') {
    await playChallenge(anonymous).get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          await playChallenge(user.id!).doc(doc.id).set({
            'id': doc.id,
            'dates': doc['dates'],
          });
        }
      }
    });
    await playGame(anonymous).get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          await playGame(user.id!).doc(doc.id).set({
            'id': doc.id,
            'dates': doc['dates'],
          });
        }
      }
    });
    await playQuestionair(anonymous).get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          await playQuestionair(user.id!).doc(doc.id).set({
            'id': doc.id,
            'dates': doc['dates'],
          });
        }
      }
    });
    await favoriteQuestions(anonymous).get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          await favoriteQuestions(user.id!).doc(doc.id).set({
            'id': doc.id,
            'dates': doc['dates'],
          });
        }
      }
    });
  }
  await userController.getUserData(user.id!);
  await utilsRef
      .doc(AppStrings.support)
      .update({'users': FieldValue.increment(1)});
}

Future<bool> addFavQuestion(Questions question) async {
  try {
    if (userController.favQuestions.contains(question.id)) {
      userController.favQuestions.remove(question.id);
      await favoriteQuestions(userController.user.value.id!)
          .doc(question.id)
          .delete();
    } else {
      userController.favQuestions.add(question.id!);
      await favoriteQuestions(userController.user.value.id!)
          .doc(question.id)
          .set({'id': question.id, 'date': DateTime.now()});
    }
    await userController.fetchFavQuestions(userController.user.value.id!);
    return true;
  } catch (e) {
    userController.favQuestions.remove(question.id!);
    debugPrint('Add fav questions: $e');
    // throw Exception(e);
    return false;
  }
}

addRequest() async {
  await utilsRef
      .doc(AppStrings.support)
      .update({'requests': FieldValue.increment(1)});
}

Future<bool> checkLogin(BuildContext context) async {
  try {
    if (userController.isAuth.value &&
        userController.user.value.anonymous == false) {
      return buySubscription();
    } else {
      return signupDialog(context).then((value) async {
        debugPrint('userid: ${userController.user.value.id}');
        if (value) {
          userController.user.value.premium = true;
          await userRef
              .doc(userController.user.value.id)
              .update({'premium': true});
          return await buySubscription(value);
        }
        return false;
      });
    }
  } catch (e) {
    // Get.back();
    debugPrint('Subscription: $e');
    // throw Exception(e);
    return false;
  }
}

Future<bool> buySubscription([bool loading = false]) async {
  try {
    if (loading) loadingDialog();
    final Subscriptions subscription = Subscriptions(
      id: userController.user.value.id,
      generated: DateTime.now(),
      ongoing: true,
    );
    await subscriptionRef.doc(subscription.id).set(subscription.toMap());
    userController.user.value.premium = true;
    await userRef.doc(userController.user.value.id).update({'premium': true});
    await userController.getUserData(userController.user.value.id!);
    Get.back();
    return true;
  } catch (e) {
    if (loading) Get.back();
    debugPrint('Subscription: $e');
    // throw Exception(e);
    return false;
  }
}
