// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iq/model/challenges.dart';

import '../backend/cloud_firestore.dart';
import '../backend/firebase_storage.dart';
import '../global/functions.dart';
import '../model/by_model.dart';
import '../widgets/custom_images.dart';
import '../constants/constants.dart';
import '../constants/ui.dart';
import '../global/refs.dart';
import '../model/questionair.dart';
import '../model/questions.dart';
import '../model/reasons.dart';
import '../theme/input_decoration.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/loading_widgets.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  final RxInt type = (-1).obs;
  final RxInt length = 1.obs;
  final RxString picture = ''.obs;

  final TextEditingController title = TextEditingController();
  final TextEditingController name = TextEditingController();

  RxList<TextEditingController> questions =
      <TextEditingController>[TextEditingController()].obs;
  // RxList<Map<String, dynamic>> reasons = <Map<String, dynamic>>[
  //   {'type': -1, 'reason': TextEditingController()},
  // ].obs;
  RxList<int> categories = <int>[].obs;
  final TextEditingController submit = TextEditingController();
  final TextEditingController designed = TextEditingController();
  final TextEditingController challenge = TextEditingController();
  final TextEditingController liked = TextEditingController();

  setType(int value) {
    type.value = value;
    setQuestions(1);
    setState(() {});
  }

  setQuestions(int value) {
    length.value = value;
    for (int i = 0; i < length.value; i++) {
      questions.add(TextEditingController());
    }
    setState(() {});
  }

  // addReason() {
  //   setState(() {
  //     reasons.add({'type': -1, 'reason': TextEditingController()});
  //   });
  // }

  addQuestionair() async {
    Get.focusScope!.unfocus();
    form.currentState!.save();
    bool state = form.currentState!.validate();
    try {
      if (state && picture.value != '') {
        //categories.isNotEmpty &&
        loadingDialog();
        final String id = getRandomString();
        final Questionair questionair = Questionair(
          id: id,
          name: type.value == 0 ? name.text : title.text,
          categories: categories,
          // reason: setReason(),
          questions: [],
          added: false,
          status: 0,
          type: type.value,
          generated: DateTime.now(),
          by: ByModel(
            name: name.text,
            profile: picture.value == ''
                ? ''
                : await uploadFile(picture.value, 'Questionair/$id'),
          ),
          reason: Reasons(
            liked: liked.text,
            submitted: submit.text,
            challenge: challenge.text,
            designedto: designed.text,
          ),
        );
        for (int i = 0; i < length.value; i++) {
          if (questions[i].text.isNotEmpty) {
            questionair.questions!.add(
              Questions(type: 0, question: questions[i].text),
            );
          }
        }
        await questionairRef.doc(questionair.id).set(questionair.toMap());
        await addRequest();
        Get.back();
        Get.back();
        Get.showSnackbar(
          Ui.SuccessSnackBar(message: 'Questionair generated successfully'),
        );
        // } else if (categories.isEmpty && picture.value == '') {
        //   Get.showSnackbar(
        //   Ui.ErrorSnackBar(
        //     message: 'Please select at least one category and add your picture',
        //   ),
        // );
        // } else if (categories.isEmpty) {
        //   Get.showSnackbar(
        //     Ui.ErrorSnackBar(message: 'Please select at least one category'),
        //   );
      } else if (picture.value == '') {
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Please select add your picture'),
        );
      }
    } catch (e) {
      if (state) Get.back();
      debugPrint('Questionair Error: $e');
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again later.'));
      throw Exception(e);
    }
  }

  addChallenge() async {
    Get.focusScope!.unfocus();
    form.currentState!.save();
    bool state = form.currentState!.validate();
    try {
      if (state && picture.value != '') {
        //categories.isNotEmpty &&
        loadingDialog();
        final String id = getRandomString();
        final Challenges questionair = Challenges(
          id: id,
          name: title.text,
          categories: categories,
          questions: [],
          added: false,
          status: 0,
          created: DateTime.now(),
          by: ByModel(
            name: name.text,
            profile: picture.value == ''
                ? ''
                : await uploadFile(picture.value, 'Questionair/$id'),
          ),
          reasons: Reasons(
            liked: liked.text,
            submitted: submit.text,
            challenge: challenge.text,
            designedto: designed.text,
          ),
        );
        for (int i = 0; i < length.value; i++) {
          if (questions[i].text.isNotEmpty) {
            questionair.questions!.add(
              Questions(type: 2, question: questions[i].text),
            );
          }
        }
        await challengesRef.doc(questionair.id).set(questionair.toMap());
        await addRequest();
        Get.back();
        Get.back();
        Get.showSnackbar(
          Ui.SuccessSnackBar(message: 'Challenge generated successfully'),
        );
        // } else if (categories.isEmpty && picture.value == '') {
        //   Get.showSnackbar(
        //   Ui.ErrorSnackBar(
        //     message: 'Please select at least one category and add your picture',
        //   ),
        // );
        // } else if (categories.isEmpty) {
        //   Get.showSnackbar(
        //     Ui.ErrorSnackBar(message: 'Please select at least one category'),
        //   );
      } else if (picture.value == '') {
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Please select add your picture'),
        );
      }
    } catch (e) {
      if (state) Get.back();
      debugPrint('Challenge Error: $e');
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Please try again later.'));
      throw Exception(e);
    }
  }

  // Reasons setReason() {
  //   final Reasons reason = Reasons();
  //   for (int i = 0; i < reasons.length; i++) {
  //     final _reason = reasons[i];
  //     final value = _reason['reason'].text;
  //     if (_reason['type'] == 0) {
  //       reason.submitted = value;
  //     } else if (_reason['type'] == 1) {
  //       reason.designedto = value;
  //     } else if (_reason['type'] == 2) {
  //       reason.challenge = value;
  //     } else if (_reason['type'] == 3) {
  //       reason.liked = value;
  //     }
  //   }
  //   return reason;
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: pageMargin,
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline('Submit Your Own').marginOnly(bottom: 5),
                const BodyText(
                  'You can submit your questions or challenges here and as long as the administration goes through your questions. They will add it into the database',
                  color: AppColors.textSecondary,
                ).marginOnly(bottom: 30),
                const Headline('Please select an option', fontsize: 17),
                RadioListTile(
                  value: 0,
                  groupValue: type.value,
                  onChanged: (value) => setType(value!),
                  title: const BodyText('Submit your own question'),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: type.value,
                  onChanged: (value) => setType(value!),
                  title: const BodyText('Submit your own questionair'),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: type.value,
                  onChanged: (value) => setType(value!),
                  title: const BodyText('Submit Challenge'),
                ).marginOnly(bottom: 20),
                if (type.value != -1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (type.value == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fieldLabel('Question'),
                            TextFormField(
                              maxLines: null,
                              controller: questions.first,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.next,
                              // inputFormatters: [
                              //   LengthLimitingTextInputFormatter(83)
                              // ],
                              decoration: decoration(
                                hint: 'Enter your question',
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ).marginOnly(bottom: 20),
                      if (type.value == 1 || type.value == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fieldLabel(
                              type.value == 1
                                  ? 'Questionair Title'
                                  : type.value == 2
                                      ? 'Challenge Name'
                                      : '',
                            ),
                            TextFormField(
                              controller: title,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              decoration: decoration(
                                hint: type.value == 1
                                    ? 'Enter Questionair Title'
                                    : type.value == 2
                                        ? 'Enter Challenge Name'
                                        : '',
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return '*Required';
                                }
                                return null;
                              },
                            ).marginOnly(bottom: 10),
                            fieldLabel(
                              type.value == 1
                                  ? 'Questionair'
                                  : type.value == 2
                                      ? 'Challenge'
                                      : '',
                            ),
                            SizedBox(
                              width: width,
                              child: ListTile(
                                minVerticalPadding: 0,
                                contentPadding: EdgeInsets.zero,
                                title: Headline(
                                  'Number of questions for your ${type.value == 1 ? 'questionair' : 'challenge'}',
                                  fontsize: 17,
                                ),
                                trailing: DropdownButton(
                                  value: length.value,
                                  alignment: Alignment.center,
                                  onChanged: (value) => setQuestions(value!),
                                  items: List.generate(
                                    13,
                                    (index) => DropdownMenuItem(
                                      value: index + 1,
                                      child: BodyText((index + 1).toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ).marginOnly(bottom: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                length.value,
                                (index) => Row(
                                  children: [
                                    BodyText('${index + 1}. ')
                                        .marginOnly(right: 15),
                                    Expanded(
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: questions[index],
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.multiline,
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(83)
                                        // ],
                                        decoration: decoration(
                                          hint: 'Enter your question',
                                          label: 'Enter your question',
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return '*Required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ).marginOnly(bottom: 20),
                              ),
                            ),
                          ],
                        ).marginOnly(bottom: 20),
                      fieldLabel('The reason I submitted this because'),
                      TextFormField(
                        maxLines: null,
                        controller: submit,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        decoration: decoration(
                          hint: 'The reason I submitted this because',
                        ),
                      ).marginOnly(bottom: 20),
                      if (type.value == 1)
                        fieldLabel('The questionair is designed to...'),
                      if (type.value == 1)
                        TextFormField(
                          maxLines: null,
                          controller: designed,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          decoration: decoration(
                            hint: 'The questionair is designed to...',
                          ),
                        ).marginOnly(bottom: 20),
                      if (type.value == 2)
                        fieldLabel('The challenge is designed to...'),
                      if (type.value == 2)
                        TextFormField(
                          maxLines: null,
                          controller: challenge,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          decoration: decoration(
                            hint: 'The challenge is designed to...',
                          ),
                        ).marginOnly(bottom: 20),
                      fieldLabel('We like this game because'),
                      TextFormField(
                        maxLines: null,
                        controller: liked,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        decoration: decoration(
                          hint: 'We like this game because',
                        ),
                      ).marginOnly(bottom: 20),
                      // fieldLabel('Select Categories'),
                      // GridView.count(
                      //   shrinkWrap: true,
                      //   crossAxisCount: 2,
                      //   mainAxisSpacing: 15,
                      //   crossAxisSpacing: 10,
                      //   childAspectRatio: 4,
                      //   children: List.generate(
                      //     Get.find<AppServices>().categories.length,
                      //     (index) {
                      //       final category =
                      //           Get.find<AppServices>().categories[index];
                      //       return CustomCheckbox(
                      //         title: category.title,
                      //         selected: categories.isNotEmpty &&
                      //             categories.contains(category.value),
                      //         onPressed: () {
                      //           if (categories.isNotEmpty &&
                      //               categories.contains(category.value)) {
                      //             categories.remove(category.value);
                      //           } else {
                      //             categories.add(category.value);
                      //           }
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ).marginOnly(bottom: 20),
                      fieldLabel('Name'),
                      TextFormField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        decoration: decoration(hint: 'Enter your name'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                      ).marginOnly(bottom: 20),
                      // fieldLabel('Options'),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: List.generate(
                      //     reasons.length,
                      //     (index) {
                      //       final reason = reasons[index];
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           DropdownButtonFormField(
                      //             value: reason['type'],
                      //             onChanged: (value) => setState(() {
                      //               reason['type'] = value!;
                      //             }),
                      //             decoration:
                      //                 decoration(hint: 'Select an option'),
                      //             items: questionOption
                      //                 .map((e) => DropdownMenuItem(
                      //                       value: e.value,
                      //                       child: BodyText(e.title),
                      //                     ))
                      //                 .toList(),
                      //           ).marginOnly(bottom: 10),
                      //           if (reason['type'] != -1)
                      //             TextFormField(
                      //               maxLines: null,
                      //               controller: reason['reason'],
                      //               keyboardType: TextInputType.multiline,
                      //               textInputAction:
                      //                   index == (reasons.length - 1)
                      //                       ? TextInputAction.done
                      //                       : TextInputAction.next,
                      //               decoration: decoration(
                      //                 hint:
                      //                     'Why do you choose these questions\n\n\n\n\n',
                      //               ),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   reason['reason'] = value;
                      //                 });
                      //               },
                      //             ).marginOnly(bottom: 10),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                      fieldLabel('Add your picture'),
                      Center(
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.2,
                          margin: EdgeInsets.only(
                            bottom: height * 0.1,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: AppDecorations.appshadow1(),
                            image: picture.value == ''
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: providerImage(picture.value),
                                  ),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final file = await pickImage();
                              if (file != '') picture.value = file;
                              setState(() {});
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                        text: 'Submit Question',
                        onPressed: () async => {
                          if (type.value == 2)
                            {await addChallenge()}
                          else
                            {await addQuestionair()}
                        },
                      ).marginOnly(left: 15, right: 15, bottom: 20),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
