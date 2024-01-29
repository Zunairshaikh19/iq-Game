import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/constants/ui.dart';

import '../../backend/cloud_firestore.dart';
import '../../global/refs.dart';
import '../../model/games.dart';
import '../../widgets/loading_widgets.dart';
import '../../model/player_model.dart';
import '../../services/user_services.dart';
import '../../widgets/custom_widgets.dart';
import 'game_landing_page.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({
    super.key,
    required this.categories,
    required this.players,
  });
  final List<int> categories;
  final List<Players> players;

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  List<Games> games = <Games>[];

  fetchGames() async {
    await gameRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          final game = Games.fromMap(doc);
          if (checkQuestion(game)) games.add(game);
        }
        games.sort((a, b) => a.name!.compareTo(b.name!));
      }
    });
    setState(() {});
  }

  bool checkQuestion(Games game) {
    for (var question in game.questions!) {
      for (int i = 0; i < widget.categories.length; i++) {
        if (question.categories!.contains(widget.categories[i])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    setState(() {
      fetchGames();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Headline('Select a game')),
      body: games.isEmpty
          ? CircularLoadingWidget(
              height: height * 0.8,
              onCompleteText: 'No games available for the selected categories',
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(
                  games.length,
                  (index) {
                    final Games game = games[index];
                    game.players = [];
                    return GameTile(
                      game: game,
                      ontap: () async => Get.find<UserServices>().premium ||
                              game.premium! == false
                          ? {
                              game.players = widget.players,
                              Get.off(
                                () => GameLandingPage(
                                  game: game,
                                  choose: true,
                                  color: Color(game.color!),
                                ),
                              )
                            }
                          : {
                              await checkLogin(context).then((value) {
                                if (value) {
                                  game.players = widget.players;
                                  Get.off(
                                    () => GameLandingPage(
                                      game: game,
                                      choose: true,
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
                            }, // TODO: premium
                    );
                  },
                ),
              ),
            ),
      // floatingActionButton: CustomTextButton(
      //   fontsize: 30,
      //   title: 'Launch game',
      //   weight: FontWeight.bold,
      //   onpressed: () => Get.off(() => PlayScreen(game: game)),
      // ),
      // body: StreamBuilder(
      //   stream: gameRef
      //       .where('categories', arrayContainsAny: widget.categories)
      //       .orderBy('name')
      //       .snapshots(),
      //   builder: (context, AsyncSnapshot snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting ||
      //         snapshot.hasError ||
      //         !snapshot.hasData ||
      //         snapshot.data.docs.isEmpty) {
      //       return CircularLoadingWidget(
      //         height: height * 0.8,
      //         onCompleteText: 'No games available for the selected categories',
      //       );
      //     }
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //       child: GridView.count(
      //         crossAxisCount: 3,
      //         childAspectRatio: 0.7,
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         children: List.generate(
      //           snapshot.data.docs.length,
      //           (index) {
      //             final Games game = Games.fromMap(snapshot.data.docs[index]);
      //             game.players = [];
      //             return GameTile(
      //               game: game,
      //               ontap: () async => Get.find<UserServices>().premium ||
      //                       game.premium! == false
      //                   ? {
      //                       game.players = widget.players,
      //                       Get.off(
      //                         () => GameLandingPage(
      //                           game: game,
      //                           choose: true,
      //                           color: Color(game.color!),
      //                         ),
      //                       )
      //                     }
      //                   : {
      //                       await checkLogin(context).then((value) {
      //                         if (value) {
      //                           game.players = widget.players;
      //                           Get.off(
      //                             () => GameLandingPage(
      //                               game: game,
      //                               choose: true,
      //                               color: Color(game.color!),
      //                             ),
      //                           );
      //                         } else {
      //                           Get.showSnackbar(
      //                             Ui.ErrorSnackBar(
      //                               message: 'Please try again later.',
      //                             ),
      //                           );
      //                         }
      //                       }),
      //                     }, // TODO: premium
      //             );
      //           },
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  gameTile(double width, int index, String name) {
    return Stack(
      children: [
        Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 7),
              child: SizedBox(
                width: width,
                child: Center(child: BodyText(name, fontsize: 70)),
              ),
            ),
            BodyText('Game $name', fontsize: 15),
          ],
        ),
        if (index >= 3)
          const Positioned(top: 0, right: 0, child: Icon(Icons.lock)),
      ],
    );
  }
}
