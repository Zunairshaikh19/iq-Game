// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '/constants/constants.dart';
import '/global/refs.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString([int length = 15]) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

List<String> getSerachList(String list) {
  List<String> temp = <String>[];

  /// alphabets
  for (int i = 0; i < list.length; i++) {
    temp.add(list[i]);
  }

  /// forming words
  String value = '';
  for (int i = 0; i < list.length; i++) {
    value = value + list[i];
    if (!temp.contains(value)) temp.add(value);
  }

  /// separated words
  List<String> separated = list.split(' ');
  if (separated.isNotEmpty) {
    for (int i = 0; i < separated.length; i++) {
      if (!temp.contains(separated[i])) temp.add(separated[i]);
    }
  }

  return temp;
}

String formatSetDuration(int rest) {
  final Duration duration = Duration(seconds: rest);
  return '${(duration.inMinutes).toString().padLeft(2, "0")}: ${(duration.inSeconds.remainder(60)).toString().padLeft(2, "0")}';
}

int secondsToMinutes(int seconds) => Duration(seconds: seconds).inMinutes;

String millisecondsToMinutes(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var min = (secs % 3600) ~/ 60;
  return min > 9 ? (min).toString().padLeft(2, '0') : min.toString();
}

String formatDate(DateTime date) => DateFormat('dd MMMM, yyyy').format(date);

int getAge(DateTime date) => DateTime.now().difference(date).inDays ~/ 365.25;

String formatNumber(int number) => NumberFormat().format(number);

String agoFormat(DateTime date) => timeago.format(date, locale: 'en_short');

Future<TimeOfDay?> customTimePicker(BuildContext context,
    {TimeOfDay? initialTime}) async {
  final time = await showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          onPrimary: Colors.black,
          background: Theme.of(context).cardColor,
        ),
      ),
      child: child!,
    ),
  );
  return time;
}

int percentage(int current, int total) => ((current / total) * 100).toInt();

landscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

potrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

String formatEnumText(String text) => text.replaceAll('_', ' ');

String formatError(FirebaseAuthException e) =>
    e.code.replaceAll('-', ' ').capitalizeFirst!;

String getFileName(String path) => File(path).uri.pathSegments.last;

launchWebsite(String link) => launchUrl(Uri.parse(link));

Future<String> pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return pickedFile.path;
  } else {
    return '';
  }
}
