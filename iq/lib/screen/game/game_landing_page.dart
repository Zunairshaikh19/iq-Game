import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../backend/dynamic_links.dart';
import '../../constants/constants.dart';
import '../../model/games.dart';
import '../../model/player_model.dart';
import 'play_game.dart';
import '../../widgets/custom_images.dart';
import '../../widgets/custom_widgets.dart';
import '../../theme/input_decoration.dart';

class GameLandingPage extends StatefulWidget {
  const GameLandingPage({
    this.color,
    super.key,
    required this.game,
    this.choose = false,
  });
  final Color? color;
  final Games game;
  final bool choose;

  @override
  State<GameLandingPage> createState() => _GameLandingPageState();
}

class _GameLandingPageState extends State<GameLandingPage> {
  int playerLength = 1;
  List<Players> players = <Players>[Players(name: '', age: 0)];

  addPlayers(int value) {
    setState(() {
      playerLength = value;
      for (int i = 0; i < playerLength; i++) {
        players.add(Players(name: '', age: 0));
      }
    });
  }

  setPlayers() {
    setState(() {
      playerLength = (widget.game.players ?? []).length;
      players = widget.game.players ?? <Players>[];
    });
  }

  @override
  void initState() {
    if (widget.choose) setPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => Share.share(
                await generateDynamicLinks(widget.game.id, type: 1)!),
            icon: Icon(Icons.share, color: widget.color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModuleIcon(
              title: widget.game.name ?? '',
              color: widget.color,
            ),
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     text: 'Welcome to  ',
            //     style: Get.textTheme.bodyLarge!.copyWith(),
            //     children: [
            //       TextSpan(
            //         text: '${widget.game.name} ',
            //         style: Get.textTheme.displayLarge!.copyWith(
            //           fontSize: 25,
            //           color: widget.color,
            //         ),
            //       ),
            //       TextSpan(
            //         text: ' this game is designed to ${widget.game.designedto}',
            //       ),
            //     ],
            //   ),
            // ).marginOnly(bottom: 20),
            if (widget.game.description != '')
              // BodyText(widget.game.description ?? ''),
              RichText(
                text: TextSpan(
                  text: widget.game.description![0],
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: 14,
                    color: widget.color,
                  ),
                  children: [
                    TextSpan(
                      text: widget.game.description!.substring(1),
                      style: Get.textTheme.bodyLarge!,
                    ),
                  ],
                ),
              ),
            SizedBox(height: height * 0.03),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Headline('How many players?'),
                  trailing: DropdownButton<int>(
                    value: playerLength,
                    alignment: Alignment.center,
                    onChanged: (val) => addPlayers(val!),
                    items: <int>[1, 2, 3, 4]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: BodyText(e.toString()),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    const SizedBox(width: 30, child: BodyText(''))
                        .marginOnly(right: 10),
                    SizedBox(
                      width: width * 0.4,
                      child: const BodyText(
                        'Player',
                        fontsize: 17,
                        weight: FontWeight.bold,
                      ),
                    ).marginOnly(right: 10),
                    SizedBox(
                      width: width * 0.2,
                      child: const BodyText(
                        'Age',
                        fontsize: 17,
                        weight: FontWeight.bold,
                      ),
                    ).marginOnly(right: 10),
                  ],
                ).marginOnly(bottom: 10),
                Column(
                  children: List.generate(playerLength, (index) {
                    final player = players[index];
                    return Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: BodyText('${index + 1}.'),
                        ).marginOnly(right: 10),
                        SizedBox(
                          width: width * 0.4,
                          child: TextFormField(
                            initialValue: player.name == ''
                                ? null
                                : (player.name ?? '').capitalize!,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: inputDecoration(hint: 'Jonah'),
                            onChanged: (val) {
                              setState(() {
                                player.name = val;
                              });
                            },
                          ),
                        ).marginOnly(right: 10),
                        SizedBox(
                          width: width * 0.2,
                          child: TextFormField(
                            initialValue:
                                player.age == 0 ? null : player.age!.toString(),
                            keyboardType: TextInputType.number,
                            textInputAction: index == (players.length - 1)
                                ? TextInputAction.done
                                : TextInputAction.next,
                            decoration: inputDecoration(hint: '14'),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (val) {
                              setState(() {
                                player.age = int.parse(val);
                              });
                            },
                          ),
                        ).marginOnly(right: 10),
                      ],
                    ).marginOnly(bottom: 7);
                  }),
                ),
              ],
            ),
            SizedBox(height: height * 0.07),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.game.players = players;
                  });
                  Get.off(() => PlayScreen(game: widget.game));
                },
                child: assetImage(
                  AppIcons.play,
                  height: 100,
                  color: widget.color,
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
