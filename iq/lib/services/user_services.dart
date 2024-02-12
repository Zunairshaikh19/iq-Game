import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iq/backend/firebase_auth.dart';

import '/controllers/user_controller.dart';
import '/model/settings.dart';
import '/model/subscriptions.dart';
import '/model/users.dart';

class UserServices extends GetxService {
  final UserController controller = Get.put(UserController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Assuming 'users' is the name of your collection
  CollectionReference get userRef => _firestore.collection('Users');
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
  String get userbio => user.bio ?? '';

  List<String> get favQuestions => controller.favQuestions;
  bool isFavQuestion(String id) => favQuestions.contains(id);

  Future<void> updateUserBio(String newBio) async {
    final String userId = user.id ?? ''; // Get the user ID here

    // Check if the document exists
    final userDoc = await userRef.doc(userId).get();

    if (userDoc.exists) {
      // Document exists, update it
      await userRef.doc(userId).update({'bio': newBio});
    } else {
      // Document doesn't exist, create it
      await userRef.doc(userId).set({'bio': newBio});
    }
    user.bio = newBio;
    // Print the document data
    print('UserRef Doc Data: ${userDoc.data()}');
  }
}
