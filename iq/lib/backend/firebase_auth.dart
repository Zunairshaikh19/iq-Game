import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/ui.dart';
import '../controllers/user_controller.dart';
import '../global/functions.dart';
import '../global/refs.dart';
import '../model/users.dart';
import '../screen/home.dart';
import '../widgets/custom_dialogs.dart';
import '../widgets/loading_widgets.dart';
import 'cloud_firestore.dart';

final UserController userController = Get.find();

Future setupCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AppStrings.userid, userController.user.value.id!);
  prefs.setBool(AppStrings.isLogin, true);
}

Future clearCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AppStrings.userid, '');
  prefs.setBool(AppStrings.isLogin, false);
}

Future logout() async {
  await auth.signOut();
  userController.clearData();
  await clearCache();
  Get.offAll(() => const HomeScreen());
}

Future<bool> login(String email, String password, [bool dialog = false]) async {
  loadingDialog();
  try {
    final userCredentials =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return await checkAccountStatus(userCredentials, password, dialog);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      debugPrint('No user found for that email.');
      Get.back();
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: formatError(e),
          message:
              "We are sorry to inform you that there is no user registered under this email.\nPlease try to login using another email.",
        ),
      );

      return false;
    } else if (e.code == 'wrong-password') {
      debugPrint('Wrong password provided for that user.');
      Get.back();
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: formatError(e),
          message:
              "The password you have entered is incorrect.\nPleases try again with another password.\nIf you have forget your password then try resetting it.",
        ),
      );
      return false;
    } else {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
    }
    return false;
  } catch (e) {
    Get.back();
    debugPrint('Login Error: $e');
    Get.showSnackbar(
      Ui.ErrorSnackBar(
        title: 'Something went wrong!',
        message: 'Please try again later',
      ),
    );
    throw Exception(e);
  }
}

Future forgetPassword(String email) async {
  try {
    loadingDialog();
    await auth.sendPasswordResetEmail(email: email).then((value) {
      debugPrint('send');
      Get.back();
      Get.back();
      Get.showSnackbar(
        Ui.SuccessSnackBar(
          message:
              'Email send successfully. Please check your inbox and update your password',
        ),
      );
      return true;
    });
  } on FirebaseAuthException catch (e) {
    debugPrint(e.code);
    if (e.code == 'user-not-found') {
      debugPrint('No user found for that email.');
      Get.back();
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: formatError(e),
          message:
              "We are sorry to inform you that there is no user registered under this email.\nPlease try to login using another email.",
        ),
      );
      return false;
    } else {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
    }
    return false;
  } catch (e) {
    Get.back();
    debugPrint('Forget Password: $e');
    Get.showSnackbar(
      Ui.ErrorSnackBar(title: 'Error!', message: 'Please try again later.'),
    );
    throw Exception(e);
  }
}

Future<bool> applicationLoginFlow(
  UserCredential credential,
  String password,
  bool dialog,
) async {
  return await userRef.doc(credential.user!.uid).get().then((value) async {
    if (value.data() != null) {
      userController.isAuth.value = true;
      userController.user.value = UserModel.fromMap(value.data());
      await userController.getSettings(credential.user!.uid);
      if (userController.user.value.premium!) {
        await userController.getSubscription(credential.user!.uid);
      }
      await userController.fetchData(credential.user!.uid);
      await userStatus(credential.user!.uid, true);

      /// password
      if (userController.user.value.password != password) {
        await adminRef.doc(credential.user!.uid).update({'password': password});
      }

      await setupCache();
      Get.back();
      if (dialog == false) Get.offAll(() => const HomeScreen());
      return true;
    } else {
      await auth.signOut();
      Get.back();
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          message:
              'The credentials you entered, are not an authenticated for this application. Please try again with another credentials',
        ),
      );
      return false;
    }
  });
}

Future deleteUserAccount() async {
  loadingDialog();
  try {
    await auth
        .signInWithEmailAndPassword(
            email: userController.user.value.email!,
            password: userController.user.value.password!)
        .then((value) async {
      await value.user!.delete();
      await userRef.doc(userController.user.value.id).update({'deleted': true});
      await userStatus(userController.user.value.id!, false);
      clearCache();

      userController.clearData();
      Get.offAll(() => const HomeScreen());
    });
  } catch (e) {
    Get.back();
    debugPrint('Delete Account: $e');
    throw Exception(e);
  }
}

Future<bool> checkAccountStatus(
  UserCredential credential,
  String password,
  bool dialog,
) async {
  return await disabledRef.doc(credential.user!.uid).get().then((val) async {
    if (val.data() != null) {
      deletedDialog(credential.user!.uid);
      return false;
    } else {
      return await deletedRef.doc(credential.user!.uid).get().then((value) {
        if (value.data() != null) {
          deletedDialog(credential.user!.uid);
          return false;
        } else {
          return applicationLoginFlow(credential, password, dialog);
        }
      });
    }
  });
}

Future<bool> signUp(UserModel user, [bool dialog = false]) async {
  loadingDialog();
  try {
    final userCredentials = await auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
    return applicationSignupFlow(userCredentials, user, dialog);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      Get.back();
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: formatError(e),
          message:
              "Looks like there is already an account registered with this email address. Try login instead of sign up"
                  .tr,
        ),
      );
      return false;
    } else {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(message: formatError(e)));
    }
    return false;
  } catch (e) {
    Get.back();
    debugPrint('Signup Error: $e');
    Get.showSnackbar(
      Ui.ErrorSnackBar(
        title: 'Something went wrong!',
        message: 'Please try again later'.tr,
      ),
    );
    throw Exception(e);
  }
}

Future<bool> applicationSignupFlow(
  UserCredential credential,
  UserModel user,
  bool dialog,
) async {
  String id = '';
  if (userController.user.value.anonymous!) {
    id = userController.user.value.id ?? '';
  }

  userController.isAuth.value = true;
  userController.user.value = UserModel(
    id: credential.user!.uid,
    name: user.name,
    email: user.email,
    password: user.password,
    premium: false,
    deleted: false,
    profile: AppIcons.logo,
    search: getSerachList(user.name!.toUpperCase()),
  );
  await addUser(userController.user.value, id);
  await setupCache();
  if (dialog == false) Get.offAll(() => const HomeScreen());
  if (dialog) Get.back();
  return true;
}

Future signInAnonymously() async {
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    userController.user.value.id = userCredential.user!.uid;
    userController.isAuth.value = true;
    userController.user.value.name = userCredential.user!.displayName;
    userController.user.value.anonymous = true;
    await userRef
        .doc(userCredential.user!.uid)
        .set(userController.user.value.toMap());
    debugPrint("Signed in with temporary account.");
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        debugPrint("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        debugPrint("Unknown error.");
    }
  }
}
