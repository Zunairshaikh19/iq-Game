import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/services/user_services.dart';

import '../../constants/constants.dart';
import '../../global/refs.dart';
import '../../model/challenges.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import '../home.dart';

class LaunchChallengeScreen extends StatelessWidget {
  LaunchChallengeScreen({required this.challenge, super.key});
  final Challenges challenge;
  final String userid = Get.find<UserServices>().userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black.withOpacity(0.3),
      //   onPressed: () => Get.off(() => PlayChallenge(challenge: challenge)),
      //   child: assetImage(
      //     AppIcons.play,
      //     height: 120,
      //     color: challenge.color == 0
      //         ? AppColors.primary
      //         : Color(challenge.color!),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              text: 'SAVE YOUR ANSWER'.toUpperCase(),
              primary: AppColors.primary1,
              onPressed: () async {},
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              text: 'Complete'.toUpperCase(),
              primary: challenge.color == 0
                  ? AppColors.primary1
                  : Color(challenge.color!),
              onPressed: () async {
                await playChallenge(userid)
                    .doc(userid)
                    .get()
                    .then((value) async {
                  if (value.data() != null) {
                    await playChallenge(userid).doc(challenge.id).update({
                      'dates': FieldValue.arrayUnion([DateTime.now()]),
                    });
                  } else {
                    await playChallenge(userid).doc(challenge.id).set({
                      'dates': [DateTime.now()],
                      'id': challenge.id
                    });
                  }
                });
                Get.offAll(() => const HomeScreen());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: pageMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Headline(
                'Questions',
                color: Colors.white,
                fontsize: 30,
                align: TextAlign.center,
              ).marginOnly(bottom: 20),
            ),
            Column(
              children: List.generate(
                challenge.questions!.length,
                (index) {
                  final question = challenge.questions![index];
                  return Row(
                    children: [
                      BodyText(
                        '${index + 1}.',
                        color: Colors.white,
                        fontsize: 17,
                      ).marginOnly(right: 10),
                      Expanded(
                        child: BodyText(
                          ('${question.question ?? ''}${question.question!.endsWith('?') ? '' : '?'}')
                              .capitalize!,
                          fontsize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ).marginOnly(bottom: 10);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // set the border color here
                        width: 2.0, // set the border width here
                      ),
                    ),
                    contentPadding: EdgeInsets.all(12.0),
                    hintText: 'Enter text',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // set the border color here
                        width: 2.0, // set the border width here
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
