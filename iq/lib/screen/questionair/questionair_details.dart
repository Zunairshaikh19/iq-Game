import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_buttons.dart';
import '../../model/questionair.dart';
import '../../widgets/custom_widgets.dart';
import 'questions_list.dart';

class QuestionairDetails extends StatelessWidget {
  const QuestionairDetails({required this.questionair, super.key});
  final Questionair questionair;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModuleIcon(
              title: questionair.name ?? '',
              color: questionair.color == 0
                  ? Colors.black
                  : Color(questionair.color!),
            ),
            if (questionair.reason!.submitted != '' ||
                questionair.reason!.designedto != '' ||
                questionair.reason!.challenge != '' ||
                questionair.reason!.liked != '')
              RichText(
                text: TextSpan(
                  style: Get.textTheme.bodyLarge!.copyWith(fontSize: 14),
                  children: [
                    if (questionair.reason!.submitted != '')
                      TextSpan(
                        text:
                            'The reason of submitting this questionair is because ',
                        children: [
                          TextSpan(text: questionair.reason!.submitted ?? '')
                        ],
                      ),
                    if (questionair.reason!.designedto != '')
                      TextSpan(
                        text: ' The questionair is designed to ',
                        children: [
                          TextSpan(text: questionair.reason!.designedto ?? '')
                        ],
                      ),
                    if (questionair.reason!.challenge != '')
                      TextSpan(
                        text: ' The challenge is designed to ',
                        children: [
                          TextSpan(text: questionair.reason!.challenge ?? '')
                        ],
                      ),
                    if (questionair.reason!.liked != '')
                      TextSpan(
                        text: ' We liked this game because ',
                        children: [
                          TextSpan(text: questionair.reason!.liked ?? '')
                        ],
                      ),
                  ],
                ),
              ),
            SizedBox(height: height * 0.03),
            Align(
              alignment: Alignment.centerRight,
              child: CustomIconTextButton(
                title: 'Launch Questionair',
                color: questionair.color == 0
                    ? Colors.black
                    : Color(questionair.color!),
                onpressed: () {
                  // TODO: premium screen
                  Get.off(() => QuestionsListScreen(questionair: questionair));
                },
              ),
            ),
            // const Headline('Questions').marginOnly(bottom: 20),
            // Column(
            //   children: List.generate(
            //     questionair.questions!.length,
            //     (index) {
            //       final question = questionair.questions![index];
            //       return Row(
            //         children: [
            //           BodyText('${index + 1}.').marginOnly(right: 10),
            //           Expanded(
            //             child: BodyText((question.question ?? '').capitalize!),
            //           ),
            //         ],
            //       ).marginOnly(bottom: 10);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
