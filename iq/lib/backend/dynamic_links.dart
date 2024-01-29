import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../global/refs.dart';

const String url = 'https://iqapp.page.link';

AndroidParameters android = AndroidParameters(
  packageName: 'com.iqapps.iq',
  minimumVersion: 1,
  fallbackUrl: Uri.parse(
    'https://play.google.com/store/apps/details?id=com.iqapps.iq',
  ),
);

IOSParameters ios = IOSParameters(
  bundleId: 'com.iqapps.iq',
  fallbackUrl: Uri.parse('https://apps.apple.com/us/app/com.iqapps.iq'),
);

/// type: 0: app link, 1: game
Future<String>? generateDynamicLinks(String? id, {int type = 0}) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: url,
    link: Uri.parse('$url?id=$id&type=$type'),
    androidParameters: android,
    iosParameters: ios,
  );

  final ShortDynamicLink shortDynamicLink =
      await dynamicLinks.buildShortLink(parameters);
  final Uri shortUrl = shortDynamicLink.shortUrl;
  return shortUrl.toString();
}
