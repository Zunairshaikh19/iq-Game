import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/backend/cloud_firestore.dart';
import 'package:iq/model/challenges.dart';

import '../constants/ui.dart';
import '/model/questionair.dart';
import '/global/refs.dart';
import '/model/games.dart';
import '/services/app_services.dart';
import '/services/user_services.dart';
import '/widgets/custom_images.dart';
import '/widgets/custom_widgets.dart';
import '/constants/constants.dart';
import '/controllers/dashboard_controller.dart';
import 'challenges/challenge_details.dart';
import 'profile/user_profile.dart';
import 'questionair/questionair_details.dart';
import 'submit_your_own.dart';
import 'game/game_landing_page.dart';
import 'game/choose_category.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: IconButton(
        iconSize: 70,
        padding: EdgeInsets.zero,
        onPressed: () => Get.to(() => ChooseCategory()),
        icon: const Icon(Icons.play_arrow, color: AppColors.primary1),
      ),
      appBar: AppBar(
        title: const Headline('Home'),
        actions: [
          Obx(
            () => InkWell(
              onTap: () {
                if (Get.find<UserServices>().anonymous == false) {
                  Get.to(() => const UserProfileScreen());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (Get.find<UserServices>().user?.anonymous ?? true)
                    ? assetImage(AppIcons.icon, color: Colors.black)
                    : profileIcon(
                        Get.find<UserServices>().user?.profile ?? '', 25),
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: ListView.builder(
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        controller: Get.find<DashboardController>().controller,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemBuilder: (context, index) => homeWidgets(index, width, context),
        // children: [
        //   sampleList(),
        //   gameList(width),
        //   questionairList(width),
        //   challengeList(width),
        //   // Column(
        //   //   crossAxisAlignment: CrossAxisAlignment.start,
        //   //   children: [
        //   //     const Headline('How to play?').marginOnly(bottom: 15),
        //   //     Column(
        //   //       crossAxisAlignment: CrossAxisAlignment.start,
        //   //       children: List.generate(
        //   //         3,
        //   //         (index) => BodyText(
        //   //           '${index + 1} Select a game, then press next and keep going',
        //   //         ).marginOnly(bottom: 10),
        //   //       ),
        //   //     ),
        //   //   ],
        //   // ),
        //   // const Center(
        //   //   child: CustomImageWidget(
        //   //     image: AppIcons.logoSvg,
        //   //     // height: 250,
        //   //   ),
        //   // ).marginOnly(bottom: 20),
        //   // TextFormField(
        //   //   readOnly: true,
        //   //   maxLines: null,
        //   //   keyboardType: TextInputType.multiline,
        //   //   decoration: decoration(hint: 'Textbox\n\n\n\n\n'),
        //   // ),
        // ],
      ),
    );
  }

  Widget homeWidgets(int value, double width, BuildContext context) {
    switch (value) {
      case 0:
        return sampleList(context);
      case 1:
        return const GamesList();
      case 2:
        return const QuestionairList();
      case 3:
        return const ChallengeList();
      default:
        return Container();
    }
  }

  sampleList(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(
                      () => GameLandingPage(
                        game: Get.find<AppServices>().games,
                        color: Color(Get.find<AppServices>().games.color!),
                      ),
                    ),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Headline(
                              Get.find<AppServices>().games.search!.first,
                              fontsize: 50,
                              align: TextAlign.center,
                              font: AppStrings.colaberate,
                              color:
                                  Color(Get.find<AppServices>().games.color!),
                            ),
                            BodyText(
                              (Get.find<AppServices>().games.name ?? '')
                                  .capitalize!,
                              align: TextAlign.center,
                              color:
                                  Color(Get.find<AppServices>().games.color!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(
                      () => QuestionairDetails(
                        questionair: Get.find<AppServices>().questionair,
                      ),
                    ),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Headline(
                              Get.find<AppServices>()
                                  .questionair
                                  .name![0]
                                  .toUpperCase(),
                              fontsize: 50,
                              align: TextAlign.center,
                              font: AppStrings.colaberate,
                              color: Color(
                                  Get.find<AppServices>().questionair.color!),
                            ),
                            BodyText(
                              (Get.find<AppServices>().questionair.name ?? '')
                                  .capitalize!,
                              align: TextAlign.center,
                              color: Color(
                                  Get.find<AppServices>().questionair.color!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(() => const SubmitScreen()),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.question_answer_outlined,
                              size: 50,
                            ),
                            BodyText(
                              'Create your own',
                              align: TextAlign.center,
                              // font: AppStrings.colaberate,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).marginOnly(bottom: 20),
            // const Divider(thickness: 5).marginOnly(bottom: 10),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(
                      () => GameLandingPage(
                        game: Get.find<AppServices>().games,
                        color: Color(Get.find<AppServices>().games.color!),
                      ),
                    ),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Headline(
                              Get.find<AppServices>().games.search!.first,
                              fontsize: 50,
                              align: TextAlign.center,
                              font: AppStrings.colaberate,
                              color:
                                  Color(Get.find<AppServices>().games.color!),
                            ),
                            BodyText(
                              (Get.find<AppServices>().games.name ?? '')
                                  .capitalize!,
                              align: TextAlign.center,
                              color:
                                  Color(Get.find<AppServices>().games.color!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(
                      () => QuestionairDetails(
                        questionair: Get.find<AppServices>().questionair,
                      ),
                    ),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Headline(
                              Get.find<AppServices>()
                                  .questionair
                                  .name![0]
                                  .toUpperCase(),
                              fontsize: 50,
                              align: TextAlign.center,
                              font: AppStrings.colaberate,
                              color: Color(
                                  Get.find<AppServices>().questionair.color!),
                            ),
                            BodyText(
                              (Get.find<AppServices>().questionair.name ?? '')
                                  .capitalize!,
                              align: TextAlign.center,
                              color: Color(
                                  Get.find<AppServices>().questionair.color!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(() => const SubmitScreen()),
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.question_answer_outlined,
                              size: 50,
                            ),
                            BodyText(
                              'Create your own',
                              align: TextAlign.center,
                              // font: AppStrings.colaberate,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }
    });
  }
}

class ChallengeList extends StatelessWidget {
  const ChallengeList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: challengesRef
          .where('status', isEqualTo: 1)
          .orderBy('name')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data.docs.isEmpty) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline('Challenges').marginOnly(bottom: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: List.generate(
                snapshot.data.docs.length,
                (index) {
                  final challenge =
                      Challenges.fromMap(snapshot.data.docs[index]);
                  return ChallengeTile(
                    challenge: challenge,
                    onTap: () => Get.to(
                      () => ChallengesScreeen(challenge: challenge),
                    ),
                  );
                },
              ),
            ).marginOnly(bottom: 20),
            const Divider().marginOnly(bottom: 10),
          ],
        );
      },
    );
  }
}

class QuestionairList extends StatelessWidget {
  const QuestionairList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: questionairRef
          .where('status', isEqualTo: 1)
          .orderBy('name')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data.docs.isEmpty) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline('Questionair').marginOnly(bottom: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: List.generate(
                snapshot.data.docs.length,
                (index) {
                  final questionair =
                      Questionair.fromMap(snapshot.data.docs[index]);
                  return QuestionairTile(
                    questionair: questionair,
                    onTap: () => Get.to(
                      () => QuestionairDetails(questionair: questionair),
                    ),
                  );
                },
              ),
            ).marginOnly(bottom: 20),
            const Divider().marginOnly(bottom: 10),
          ],
        );
      },
    );
  }
}

class GamesList extends StatelessWidget {
  const GamesList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: gameRef.orderBy('played', descending: true).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data.docs.isEmpty) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Headline('Get all access for \$2.99').marginOnly(bottom: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.76,
              children: List.generate(
                snapshot.data.docs.length,
                (index) {
                  final Games game = Games.fromMap(snapshot.data.docs[index]);
                  game.players = [];
                  return GameTile(
                    game: game,
                    ontap: () async => Get.find<UserServices>().premium ||
                            game.premium == false
                        ? {
                            Get.to(
                              () => GameLandingPage(
                                game: game,
                                choose: false,
                                color: Color(game.color!),
                              ),
                            ),
                          }
                        : {
                            // TODO premium, buying
                            await checkLogin(context).then((value) {
                              if (value) {
                                Get.to(
                                  () => GameLandingPage(
                                    game: game,
                                    choose: false,
                                    color: Color(game.color!),
                                  ),
                                );
                              } else {
                                Get.showSnackbar(
                                  Ui.ErrorSnackBar(
                                    message: 'Please try again later.',
                                  ),
                                );
                              }
                            }),
                          },
                  );
                },
              ),
            ).marginOnly(bottom: 20),
            const Divider().marginOnly(bottom: 10),
          ],
        );
      },
    );
  }
}
