import 'package:flutter/material.dart';

import '../global/enums.dart';
import '../global/functions.dart';
import '../model/app_model.dart';
import '../widgets/custom_images.dart';

class AppStrings {
  static const String font = 'OpenSans';
  static const String opensans = 'OpenSans';
  static const String colaberate = 'Colaberate';

  /// DO NOT Edit anything below this untill unless it is very neccessary
  static const String onboarding = 'onboarding';
  static const String isLogin = 'isLogin';
  static const String userid = 'userid';
  static const String categories = 'categories';
  static const String support = 'support';
  static const String channel = 'iq';
  static const String sampleGame = 'game';
  static const String sampleChallenge = 'challenge';
  static const String sampleQuestionair = 'questionair';
  static const String about = 'about';
   static const String ageGroup = 'agegroup';
}

class AppColors {
  static const Color primary = Color(0xff4CE9F6);
  static const Color primary1 = Color(0xff05C3E6);
  static const Color secondary = Color(0xffFDD60C);
  static const Color accent = Color(0xffF4A30C);
  static Color background = Colors.white.withOpacity(0.5);

  static const Color text = Colors.black; //E0EFFD
  static const Color textSecondary = Colors.grey; //Color(0xffCECECE);
  static const Color textDisabled = Color(0xff9E9FA4);

  static const Color borderColor = Color(0xff5A5A5A);
  static const Color disabled = Color(0xff636365);
  static const Color cardColor = Color(0xffE0EFFD);
  // E8772E
}

class AppIcons {
  static const String loading = 'assets/loading.gif';
  static const String logo = 'assets/icon.png'; //assets/icons/logo.png
  static const String logoSvg = 'assets/icon.png';
  static const String notification = 'assets/icons/Notification.svg';
  static const String back = 'assets/icons/back.svg';
  static const String alert = 'assets/bell.gif';
  static const String bell = 'assets/icons/bell.svg';
  static const String play = 'assets/icons/play.png';
  static const String icon = 'assets/icon.png';
  static const String forget = 'assets/icons/forget.png';

  ///
  static const String general = 'assets/icons/general.png';
  static const String silly = 'assets/icons/silly.png';
  static const String challenge = 'assets/icons/challenge.png';
  static const String complete = 'assets/icons/complete.png';
}

class AppDecorations {
  static BoxDecoration overlay([double radius = 20]) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: overlayGradient(),
    );
  }

  static LinearGradient overlayGradient() {
    return LinearGradient(
      colors: [
        const Color(0xff22252F).withOpacity(0),
        const Color(0xff4C5060),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    );
  }

  static BoxDecoration background() {
    return BoxDecoration(
      image: DecorationImage(
        image: providerImage(AppIcons.logo),
      ),
    );
  }

  static List<BoxShadow> appshadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.6),
        blurRadius: 7,
        spreadRadius: 5,
        offset: const Offset(2, 4),
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.03),
        blurRadius: 7,
        spreadRadius: 5,
        offset: const Offset(-2, -4),
      ),
    ];
  }

  static List<BoxShadow> appshadow1() {
    return [
      BoxShadow(
        color: Colors.white.withOpacity(0.2),
        blurRadius: 3,
        spreadRadius: 1,
        offset: const Offset(1, 3),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 3,
        spreadRadius: 1,
        offset: const Offset(-1, -3),
      ),
    ];
  }

  static MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static LinearGradient appGradient() {
    return const LinearGradient(
      colors: [AppColors.primary, AppColors.primary1],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    );
  }
}

List<AppModel> playOptions = <AppModel>[
  AppModel(
    PlayOption.general.name,
    PlayOption.general.index,
    image: AppIcons.general,
  ),
  AppModel(
    PlayOption.silly.name,
    PlayOption.silly.index,
    image: AppIcons.silly,
  ),
  AppModel(
    PlayOption.challenge.name,
    PlayOption.challenge.index,
    image: AppIcons.challenge,
  ),
];

List<AppModel> extraOptions = <AppModel>[
  AppModel(ExtrasOption.vunerible.name, ExtrasOption.vunerible.index),
  AppModel(ExtrasOption.spicy.name, ExtrasOption.spicy.index),
  AppModel(
    formatEnumText(ExtrasOption.xx_very_spicy.name),
    ExtrasOption.xx_very_spicy.index,
  ),
];

const List<String> alphabets = <String>['A', 'B', 'C', 'D', 'E', 'F'];

List<Color> colors = <Color>[
  AppColors.primary1,
  AppColors.accent,
  Colors.deepOrange,
  Colors.blueGrey,
  Colors.cyan,
  Colors.lime,
  AppColors.borderColor,
];

List<AppModel> questionOption = <AppModel>[
  AppModel('Select Option', -1),
  AppModel('The reason I submitted this because', 0),
  AppModel('The questionair is designed to...', 1),
  AppModel('The challenge is designed to...', 2),
  AppModel('We like this game because', 3),
];

List<AppModel> questionsList = <AppModel>[
  AppModel('The reason I submitted this because', 0),
  AppModel('The questionair is designed to...', 1),
  AppModel('The challenge is designed to...', 2),
  AppModel('We like this game because', 3),
];
