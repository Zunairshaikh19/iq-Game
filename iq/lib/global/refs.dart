import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
final ImagePicker picker = ImagePicker();

///
final userRef = firestore.collection('Users');
final adminRef = firestore.collection('Admin');
final gameRef = firestore.collection('Games');
final questionRef = firestore.collection('Questions');
final challengesRef = firestore.collection('Challenges');
final utilsRef = firestore.collection('Utils');
final settingsRef = firestore.collection('Settings');
final faqRef = firestore.collection('FAQs');
final questionairRef = firestore.collection('Questionair');
final subscriptionRef = firestore.collection('Subscription');
final disabledRef = firestore.collection('Disabled');
final deletedRef = firestore.collection('Deleted');

final deviceRef = firestore.collection('DeviceInfo');

/// Collection References
CollectionReference favoriteQuestions(String id) =>
    userRef.doc(id).collection('Questions');

CollectionReference playQuestionair(String id) =>
    userRef.doc(id).collection('Questionair');

CollectionReference playChallenge(String id) =>
    userRef.doc(id).collection('Challenge');

CollectionReference playGame(String id) => userRef.doc(id).collection('Game');

CollectionReference dquestionair(String id) =>
    deviceRef.doc(id).collection('Questionair');

CollectionReference dchallenge(String id) =>
    deviceRef.doc(id).collection('Challenge');

CollectionReference dgame(String id) => deviceRef.doc(id).collection('Game');
