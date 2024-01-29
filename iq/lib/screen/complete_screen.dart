import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/constants/constants.dart';
import 'package:iq/screen/home.dart';
import 'package:iq/widgets/custom_buttons.dart';
import 'package:iq/widgets/custom_images.dart';
import 'package:iq/widgets/custom_widgets.dart';

import '../global/functions.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({required this.title, super.key});
  final String title;

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  void initState() {
    potrait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    potrait();
    return Scaffold(
      body: Padding(
        padding: pageMargin,
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15),
              child: assetImage(AppIcons.complete),
            ),
            Headline('${widget.title} completed'.capitalize!, fontsize: 30),
            const SizedBox(height: 7),
            BodyText(
              'You have successfully completed the ${widget.title} successfully',
              color: AppColors.textSecondary,
              align: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              text: 'Go to Home'.toUpperCase(),
              onPressed: () => Get.offAll(() => const HomeScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
