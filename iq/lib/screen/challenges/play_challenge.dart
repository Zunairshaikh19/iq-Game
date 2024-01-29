import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:share_plus/share_plus.dart';

import '../../backend/cloud_firestore.dart';
import '../../backend/dynamic_links.dart';
import '../../constants/constants.dart';
import '../../model/challenges.dart';
import '../../global/functions.dart';
import '../../model/questions.dart';
import '../../services/user_services.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_dialogs.dart';
import '../../widgets/custom_widgets.dart';
import '../home.dart';

class PlayChallenge extends StatefulWidget {
  const PlayChallenge({super.key, required this.challenge});
  final Challenges challenge;

  @override
  State<PlayChallenge> createState() => _PlayChallengeState();
}

class _PlayChallengeState extends State<PlayChallenge> {
  bool clicked = false;
  Questions question = Questions(type: 0);
  int selected = 0;
  int player = 0;
  bool dialog = false;
  int length = 0;

  setClicked() {
    setState(() {
      clicked = Get.find<UserServices>().isFavQuestion(question.id!);
    });
  }

  setQuestion() {
    question = widget.challenge.questions![selected];
    setClicked();
    length = (question.question ?? '').length;
  }

  previous() {
    if (selected != 0) selected = selected - 1;
    setQuestion();
  }

  next() {
    if (selected == (widget.challenge.questions!.length - 1)) {
      Get.back();
    } else {
      if (selected != (widget.challenge.questions!.length - 1)) {
        selected = selected + 1;
      }
      setQuestion();
    }
  }

  dialogFunction(bool value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dialog = value;
        landscape();
      });
    });
  }

  @override
  void initState() {
    setState(() {
      landscape();
      setQuestion();
    });
    super.initState();
  }

  @override
  void dispose() {
    potrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    landscape();
    debugPrint(question.question!.length.toString());
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextButton(
            title: 'Exit Challenge',
            weight: FontWeight.bold,
            fontsize: 20,
            onpressed: () => Get.offAll(() => const HomeScreen()),
          ),
          if (question.type == 1)
            SizedBox(
              width: width * 0.3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BodyText(
                      'Submitted by: ${question.by!.name!.capitalize!}',
                      color: Colors.white,
                    ),
                    SizedBox(height: question.reason!.submitted != '' ? 5 : 0),
                    ReadMoreText(
                      question.reason!.submitted ?? '',
                      numLines: 2,
                      readMoreText: 'Read more',
                      readLessText: 'Read less',
                      style: Get.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ).marginOnly(bottom: 20),
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () async => Share.share(
            'What an interesting question("${question.question}"), I found at Inquisitive Questions.\n${await generateDynamicLinks('appid')!}',
          ),
          child: Column(
            children: const [
              Icon(Icons.ios_share, color: Colors.white),
            ],
          ),
        ),
        actions: [
          Tooltip(
            message: 'Add to Favorite',
            child: InkWell(
              onTap: () async {
                if (Get.find<UserServices>().isAuth) {
                  await addFavQuestion(question).then((value) {
                    debugPrint('value :$value');
                    if (value) setClicked();
                  });
                } else {
                  potrait();
                  setState(() {
                    dialog = true;
                  });
                  signupDialog(
                    context,
                    question: question,
                    dialog: dialogFunction,
                  ).then((value) {
                    if (value) setClicked();
                  });
                }

                setState(() {});
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: 30,
                    semanticLabel: 'Add to Favorite',
                    color: clicked ? AppColors.accent : Colors.white,
                  ),
                  if (clicked) const BodyText('Liked', color: AppColors.accent),
                ],
              ),
            ),
          ),
          // CustomTextButton(
          //   title: 'End',
          //   weight: FontWeight.bold,
          //   fontsize: 17,
          //   onpressed: () => Get.offAll(() => HomeScreen()),
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
        children: [
          // if ((question.question ?? '').length < 83)
          //   const SizedBox(height: 20), // const Spacer(),
          Center(
            child: BodyText(
              (question.question ?? '').capitalizeFirst!,
              fontsize: length <= 44
                  ? 60
                  : length <= 50
                      ? 55
                      : length <= 60
                          ? 50
                          : length <= 80
                              ? 40
                              : 35,
              align: TextAlign.center,
              color: Colors.white,
              // maxLines: 3,
            ).marginOnly(bottom: length > 80 ? 0 : 20, left: 15, right: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => setState(() => previous()),
                icon: const Icon(Icons.first_page_sharp),
                iconSize: 50,
                color: Colors.white,
                tooltip: 'Previous Question',
              ),
              IconButton(
                onPressed: () => setState(() => setQuestion()),
                iconSize: 40,
                icon: const Icon(Icons.refresh),
                color: Colors.white,
                tooltip: 'Reload Question',
              ),
              IconButton(
                onPressed: () => setState(() => next()),
                icon: const Icon(Icons.last_page_outlined),
                iconSize: 50,
                color: Colors.white,
                tooltip: 'Next Question',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
