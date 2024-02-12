import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/services/user_services.dart';

import '../../constants/constants.dart';
import '../../global/refs.dart';
import '../../model/questionair.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import '../home.dart';

class QuestionsListScreen extends StatelessWidget {
  QuestionsListScreen({required this.questionair, super.key});
  final Questionair questionair;
  final String userid = Get.find<UserServices>().userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(leading: const BackButton(color: Colors.white)),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: () =>
      //       Get.off(() => PlayQuestionair(questionair: questionair)),
      //   child: assetImage(AppIcons.play, height: 100, color: AppColors.primary),
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
              text: 'Be Known'.toUpperCase(),
              onPressed: () async {
                await playQuestionair(userid)
                    .doc(questionair.id)
                    .get()
                    .then((value) async {
                  if (value.data() != null) {
                    await playQuestionair(userid).doc(questionair.id).update({
                      'dates': FieldValue.arrayUnion([DateTime.now()]),
                    });
                  } else {
                    await playQuestionair(userid).doc(questionair.id).set({
                      'dates': [DateTime.now()],
                      'id': questionair.id
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
                fontsize: 30,
                color: Colors.white,
              ).marginOnly(bottom: 20),
            ),
            Column(
              children: List.generate(
                questionair.questions!.length,
                (index) {
                  final question = questionair.questions![index];
                  return ExpansionTile(
                    trailing: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: Row(
                      children: [
                        BodyText(
                          '${index + 1}.',
                          color: Colors.white,
                          fontsize: 17,
                        ).marginOnly(right: 10),
                        Expanded(
                          child: BodyText(
                            ((question.question ?? '') +
                                    (question.question!.endsWith('?')
                                        ? ''
                                        : '?'))
                                .capitalize!,
                            color: Colors.white,
                            fontsize: 20,
                          ),
                        ),
                      ],
                    ).marginOnly(bottom: 10),
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.white, // set the border color here
                                  width: 2.0, // set the border width here
                                ),
                              ),
                              contentPadding: EdgeInsets.all(12.0),
                              hintText: 'Enter Answer',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Colors.white, // set the border color here
                                  width: 2.0, // set the border width here
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
