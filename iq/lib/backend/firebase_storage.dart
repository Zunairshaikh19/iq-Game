import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../global/functions.dart';
import '../global/refs.dart';

Future<String> uploadFile(String pickedFile, String path) async {
  String link = '';
  try {
    Reference storageRef =
        storage.ref().child('$path/${getFileName(pickedFile)}');
    UploadTask uploadTask = storageRef.putFile(File(pickedFile));
    TaskSnapshot tasksnapshot = await uploadTask;

    await tasksnapshot.ref.getDownloadURL().then((url) async {
      debugPrint('url: $url');
      link = url;
      return link;
    });
    return link;
  } catch (e) {
    debugPrint('Firebase Storage Error: $e');
    throw Exception(e);
  }
}
