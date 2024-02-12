import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/backend/cloud_firestore.dart';
import 'package:iq/global/refs.dart';
import 'package:iq/screen/complete_screen.dart';
import 'package:iq/services/user_services.dart';
import 'package:iq/widgets/custom_dialogs.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:share_plus/share_plus.dart';

import '../../backend/dynamic_links.dart';
import '../../model/questions.dart';
import '../../constants/constants.dart';
import '../../global/functions.dart';
import '../../model/games.dart';
import '../../screen/home.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key, required this.game});
  final Games game;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  String userid = Get.find<UserServices>().userid;
  bool clicked = false;
  Questions question = Questions(type: 0);
  int selected = 0;
  int player = 0;
  bool dialog = false;
  int length = 0;

  increasePlay() async {
    if (widget.game.id == AppStrings.sampleGame) {
      await utilsRef
          .doc(widget.game.id)
          .update({'played': FieldValue.increment(1)});
    } else {
      await gameRef
          .doc(widget.game.id)
          .update({'played': FieldValue.increment(1)});
    }
  }

  setClicked() {
    setState(() {
      clicked = Get.find<UserServices>().isFavQuestion(question.id!);
    });
  }

  dialogFunction(bool value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dialog = value;
        landscape();
      });
    });
  }

  setQuestion() {
    question = widget.game.questions![selected];
    setClicked();
    length = (question.question ?? '').length;
  }

  previous() {
    if (selected != 0) selected = selected - 1;
    setQuestion();
  }

  next() {
    if (selected != (widget.game.questions!.length - 1)) {
      selected = selected + 1;
    } else {
      setPlayer();
    }
    setQuestion();
  }

  setPlayer() async {
    if (player != (widget.game.players!.length - 1)) {
      player = player + 1;
    } else {
      // Get.back();
      addCompleted();
      potrait();
      Get.off(() => const CompleteScreen(title: 'Game'));
    }
  }

  addCompleted() async {
    await playGame(userid).doc(widget.game.id).get().then((value) async {
      if (value.data() != null) {
        await playGame(userid).doc(widget.game.id).update({
          'dates': FieldValue.arrayUnion([DateTime.now()]),
        });
      } else {
        await playGame(userid).doc(widget.game.id).set({
          'dates': [DateTime.now()],
          'id': widget.game.id
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      increasePlay();
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
    debugPrint(length.toString());
    if (dialog == false) landscape();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                    // BodyText(
                    //   question.reason!.submitted ?? '',
                    //   align: TextAlign.end,
                    //   color: AppColors.textSecondary,
                    // ),
                  ],
                ),
              ),
            ),
        ],
      ).marginOnly(bottom: 20),
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        toolbarHeight: 35,
        leading: InkWell(
          onTap: () async => Share.share(
            'What an interesting question("${question.question}"), I found at Inquisitive Questions.\n${await generateDynamicLinks('appid')!}',
          ),
          child: Column(
            children: const [Icon(Icons.ios_share, color: Colors.white)],
          ),
        ),
        title: Headline(
          'Player ${player + 1}:    ${widget.game.players![player].name ?? ''}',
          color: Colors.white,
          align: TextAlign.center,
          weight: FontWeight.normal,
        ),
        actions: [
          CustomTextButton(
            title: 'Exit Game',
            weight: FontWeight.bold,
            fontsize: 20,
            onpressed: () => Get.offAll(() => const HomeScreen()),
          ),
          Tooltip(
            message: 'Add to Favorite',
            child: InkWell(
              onTap: () async {
                if (Get.find<UserServices>().isAuth) {
                  await addFavQuestion(question).then((value) {
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 15, top: 55, right: 15),
        children: [
          // if ((question.question ?? '').length < 83)
          //   const SizedBox(height: 30), // const Spacer(),
          Center(
            child: ReadMoreText(
              (question.question ?? '').capitalizeFirst!,
              numLines: 5,
              readMoreText: 'Read more',
              readLessText: 'Read less',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: length <= 44
                    ? 60
                    : length <= 50
                        ? 55
                        : length <= 60
                            ? 50
                            : length <= 80
                                ? 40
                                : 35,
              ),
            ),
          ).marginOnly(bottom: length > 80 ? 0 : 20, left: 15, right: 15),
          // Center(
          //   child: BodyText(
          //     (question.question ?? '').capitalizeFirst!,
          //     fontsize: length <= 44
          //         ? 60
          //         : length <= 50
          //             ? 55
          //             : length <= 60
          //                 ? 50
          //                 : length <= 80
          //                     ? 40
          //                     : 35,
          //     align: TextAlign.center,
          //     color: Colors.white,
          //     // maxLines: 3,
          //   ).marginOnly(bottom: length > 80 ? 0 : 20, left: 15, right: 15),
          // ),
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
              InkWell(
                onTap: () => setState(() => next()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    BodyText('Next', color: Colors.white, fontsize: 30),
                    Icon(
                      Icons.last_page_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
                // iconSize: 50,
                // color: Colors.white,
                // tooltip: 'Next Question',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
