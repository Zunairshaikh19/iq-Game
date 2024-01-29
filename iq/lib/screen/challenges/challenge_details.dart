import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../widgets/custom_images.dart';
import '../../widgets/custom_widgets.dart';
import '../../model/challenges.dart';
import 'launch_challenge.dart';

class ChallengesScreeen extends StatelessWidget {
  const ChallengesScreeen({required this.challenge, super.key});
  final Challenges challenge;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModuleIcon(
              title: challenge.name ?? '',
              color:
                  challenge.color == 0 ? Colors.black : Color(challenge.color!),
            ),
            if (challenge.reasons!.submitted != '' ||
                challenge.reasons!.designedto != '' ||
                challenge.reasons!.challenge != '' ||
                challenge.reasons!.liked != '')
              RichText(
                text: TextSpan(
                  style: Get.textTheme.bodyLarge!.copyWith(fontSize: 14),
                  children: [
                    if (challenge.reasons!.submitted != '')
                      TextSpan(
                        text:
                            'The reason of submitting this challenge is because ',
                        children: [
                          TextSpan(text: challenge.reasons!.submitted ?? '')
                        ],
                      ),
                    if (challenge.reasons!.designedto != '')
                      TextSpan(
                        text: ' The questionair is designed to ',
                        children: [
                          TextSpan(text: challenge.reasons!.designedto ?? '')
                        ],
                      ),
                    if (challenge.reasons!.challenge != '')
                      TextSpan(
                        text: ' The challenge is designed to ',
                        children: [
                          TextSpan(text: challenge.reasons!.challenge ?? '')
                        ],
                      ),
                    if (challenge.reasons!.liked != '')
                      TextSpan(
                        text: ' We liked this game because ',
                        children: [
                          TextSpan(text: challenge.reasons!.liked ?? '')
                        ],
                      ),
                  ],
                ),
              ),
            // BodyText(challenge.reasons!.submitted ?? ''),
            SizedBox(height: height * 0.15),
            // Column(
            //   children: [
            //     ListTile(
            //       contentPadding: EdgeInsets.zero,
            //       title: const Headline('How many players?'),
            //       trailing: DropdownButton<int>(
            //         value: 2,
            //         alignment: Alignment.center,
            //         items: <int>[1, 2, 3, 4]
            //             .map(
            //               (e) => DropdownMenuItem(
            //                 value: e,
            //                 child: BodyText(e.toString()),
            //               ),
            //             )
            //             .toList(),
            //         onChanged: (val) {},
            //       ),
            //     ),
            //     SizedBox(height: height * 0.02),
            //     Row(
            //       children: [
            //         const SizedBox(width: 30, child: BodyText(''))
            //             .marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.4,
            //           child: const BodyText(
            //             'Player',
            //             fontsize: 17,
            //             weight: FontWeight.bold,
            //           ),
            //         ).marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.2,
            //           child: const BodyText(
            //             'Age',
            //             fontsize: 17,
            //             weight: FontWeight.bold,
            //           ),
            //         ).marginOnly(right: 10),
            //       ],
            //     ).marginOnly(bottom: 10),
            //     Row(
            //       children: [
            //         const SizedBox(width: 30, child: BodyText('1.'))
            //             .marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.4,
            //           child: TextFormField(
            //             decoration: inputDecoration(hint: 'Jonah'),
            //           ),
            //         ).marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.2,
            //           child: TextFormField(
            //             decoration: inputDecoration(hint: '14'),
            //           ),
            //         ).marginOnly(right: 10),
            //       ],
            //     ).marginOnly(bottom: 7),
            //     Row(
            //       children: [
            //         const SizedBox(width: 30, child: BodyText('2.'))
            //             .marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.4,
            //           child: TextFormField(
            //             decoration: inputDecoration(hint: 'Jonah'),
            //           ),
            //         ).marginOnly(right: 10),
            //         SizedBox(
            //           width: width * 0.2,
            //           child: TextFormField(
            //             decoration: inputDecoration(hint: '14'),
            //           ),
            //         ).marginOnly(right: 10),
            //       ],
            //     ).marginOnly(bottom: 7),
            //   ],
            // ).marginOnly(bottom: 20),
            // const Headline('Select theme'),
            // GridView.count(
            //   shrinkWrap: true,
            //   crossAxisCount: 2,
            //   mainAxisSpacing: 15,
            //   crossAxisSpacing: 10,
            //   childAspectRatio: 3.5,
            //   children: List.generate(
            //     playOptions.length,
            //     (index) {
            //       return CheckboxListTile(
            //         value: index % 2 == 0 ? true : false,
            //         activeColor: AppColors.accent,
            //         onChanged: (value) {},
            //         title: BodyText(
            //           playOptions[index].title.capitalize!,
            //           fontsize: 15,
            //         ),
            //       );
            //     },
            //   ),
            // ).marginOnly(bottom: height * 0.1),
            Center(
              child: GestureDetector(
                onTap: () => Get.off(
                  () => LaunchChallengeScreen(challenge: challenge),
                ),
                child: assetImage(
                  AppIcons.play,
                  height: 100,
                  color: challenge.color == 0
                      ? Colors.black
                      : Color(challenge.color!),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}
