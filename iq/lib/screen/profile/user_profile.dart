import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/global/refs.dart';
import 'package:iq/model/app_model.dart';
import 'package:iq/model/challenges.dart';
import 'package:iq/model/games.dart';
import 'package:iq/model/questionair.dart';
import 'package:iq/screen/profile/edit_profile_screen.dart';
import 'package:iq/services/user_services.dart';
import 'package:iq/widgets/custom_buttons.dart';
import 'package:iq/widgets/custom_widgets.dart';
import 'package:iq/widgets/loading_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<AppModel> tabs = <AppModel>[
    AppModel('Challenges', 1),
    AppModel('Games', 0),
    AppModel('Questions', 2),
  ];

  RxList<Games> gameList = <Games>[].obs;
  RxList<Challenges> challengeList = <Challenges>[].obs;
  RxList<Questionair> questionairList = <Questionair>[].obs;
  RxInt selected = 0.obs;

  getHistory() async {
    await playGame(Get.find<UserServices>().userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          gameRef.doc(doc.id).get().then((value) {
            if (value.data() != null) {
              final game = Games.fromMap(value.data());
              game.dates = toDates(doc['dates'].cast<Timestamp>().toList());
              gameList.add(game);
            }
          });
        }
      }
    });
    await playChallenge(Get.find<UserServices>().userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          challengesRef.doc(doc.id).get().then((value) {
            if (value.data() != null) {
              final game = Challenges.fromMap(value.data());
              game.dates = toDates(doc['dates'].cast<Timestamp>().toList());
              challengeList.add(game);
            }
          });
        }
      }
    });
    await playQuestionair(Get.find<UserServices>().userid).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          questionairRef.doc(doc.id).get().then((value) {
            if (value.data() != null) {
              final game = Questionair.fromMap(value.data());
              game.dates = toDates(doc['dates'].cast<Timestamp>().toList());
              questionairList.add(game);
            }
          });
        }
      }
    });
    setState(() {});
  }

  List<DateTime> toDates(List<Timestamp> timestamp) {
    List<DateTime> date = <DateTime>[];
    for (int i = 0; i < timestamp.length; i++) {
      date.add(timestamp[i].toDate());
    }
    return date;
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          actions: [
            CustomTextButton(
              title: 'Edit Profile',
              onpressed: () => Get.to(() => const EditProfileScreen()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: pageMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 199, 199, 199).withOpacity(0.8),
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child:
                      profileIcon(Get.find<UserServices>().user.profile ?? ''),
                ),
              ),

              const SizedBox(height: 15),
              Center(
                child: Headline(
                  (Get.find<UserServices>().user.name ?? '').capitalize!,
                ),
              ),
              Center(
                child: Text(
                  (Get.find<UserServices>().user.email ?? '').capitalize!,
                ),
              ),
              Center(
                child: BioBox(
                  initialBio: Get.find<UserServices>().userbio,
                ),
              ),
              // Headline('History').marginOnly(bottom: 10, top: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 20),
                child: Row(
                  children: List.generate(
                    tabs.length,
                    (index) {
                      final tab = tabs[index];
                      return CustomTab(
                        tab: tab,
                        selected: selected.value == tab.value,
                        ontap: () => selected.value = tab.value,
                      );
                    },
                  ),
                ),
              ),
              if (selected.value == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gameList.isEmpty
                        ? CircularLoadingWidget(
                            height: height * 0.4,
                            onCompleteText: 'No games played yet..',
                          )
                        : LayoutBuilder(builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth ~/ 180;
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.76,
                              children: List.generate(
                                gameList.length,
                                (index) {
                                  final Games game = gameList[index];
                                  game.players = [];
                                  return GameTile(game: game, ontap: () {});
                                },
                              ),
                            );
                          }),
                  ],
                )
              else if (selected.value == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    challengeList.isEmpty
                        ? CircularLoadingWidget(
                            height: height * 0.4,
                            onCompleteText:
                                'No challenges has been played yet..',
                          )
                        : LayoutBuilder(builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth ~/ 180;
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.76,
                              children: List.generate(
                                challengeList.length,
                                (index) {
                                  final game = challengeList[index];
                                  return ChallengeTile(
                                    challenge: game,
                                    onTap: () {},
                                  );
                                },
                              ),
                            );
                          }),
                  ],
                )
              else if (selected.value == 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    questionairList.isEmpty
                        ? CircularLoadingWidget(
                            height: height * 0.4,
                            onCompleteText: 'No questionairs has played yet..',
                          )
                        : LayoutBuilder(builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth ~/ 180;
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.76,
                              children: List.generate(
                                questionairList.length,
                                (index) {
                                  final game = questionairList[index];
                                  return QuestionairTile(
                                    questionair: game,
                                    onTap: () {},
                                  );
                                },
                              ),
                            );
                          }),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}

class BioBox extends StatefulWidget {
  final String? initialBio;

  const BioBox({Key? key, this.initialBio}) : super(key: key);

  @override
  _BioBoxState createState() => _BioBoxState();
}

class _BioBoxState extends State<BioBox> {
  bool isEditing = false;
  late String bioText;

  @override
  void initState() {
    super.initState();
    bioText = widget.initialBio ?? 'empty';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionTile(
            title: Text('Bio'),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(bioText),
                trailing: isEditing
                    ? IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () async {
                          // Save changes and exit editing mode
                          setState(() {
                            isEditing = false;
                          });

                          // Update bio in Firebase
                          updateUserBio(bioText);
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Enter editing mode
                          setState(() {
                            isEditing = true;
                          });
                        },
                      ),
              ),
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: bioText,
                    maxLines: null,
                    onChanged: (value) {
                      // Update bioText when editing
                      setState(() {
                        bioText = value;
                      });
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to update the user's bio
  void updateUserBio(String newBio) {
    final userServices = Get.find<UserServices>();
    userServices.updateUserBio(newBio);
  }
}
