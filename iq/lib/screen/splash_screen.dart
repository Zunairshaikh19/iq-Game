import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/custom_images.dart';
import '/widgets/custom_widgets.dart';
import '/constants/constants.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () => Get.offAll(() => const HomeScreen()),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppDecorations.appGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  assetImage(
                    AppIcons.logo,
                    color: Colors.white,
                    height: 150,
                  ).marginOnly(bottom: 30),
                  const Headline(
                    'Inquisitive Questions',
                    font: AppStrings.colaberate,
                    color: Colors.white,
                    fontsize: 27,
                  ).marginOnly(bottom: 5),
                  const BodyText(
                    'The Conversation Game',
                    fontsize: 18,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.to(() => const HomeScreen()),
              child: assetImage(
                AppIcons.play,
                height: 100,
                color: Colors.white,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
