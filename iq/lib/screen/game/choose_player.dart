import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../model/player_model.dart';
import '../../theme/input_decoration.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import 'choose_game.dart';

class ChoosePlayers extends StatefulWidget {
  const ChoosePlayers({super.key, required this.categories});
  final List<int> categories;

  @override
  State<ChoosePlayers> createState() => _ChoosePlayersState();
}

class _ChoosePlayersState extends State<ChoosePlayers> {
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextButton(
            title: 'Play game',
            fontsize: 20,
            weight: FontWeight.bold,
            onpressed: () => Get.off(
              () => ChooseGame(categories: widget.categories, players: players),
            ),
          ),
        ],
      ).marginOnly(bottom: 10),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Headline('How many players?'),
              trailing: DropdownButton<int>(
                value: playerLength,
                alignment: Alignment.center,
                items: <int>[1, 2, 3, 4]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: BodyText(e.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (val) => addPlayers(val!),
              ),
            ),
            SizedBox(height: height * 0.05),
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
              children: List.generate(
                playerLength,
                (index) {
                  final player = players[index];
                  return Row(
                    children: [
                      SizedBox(width: 30, child: BodyText('${index + 1}.'))
                          .marginOnly(right: 10),
                      SizedBox(
                        width: width * 0.4,
                        child: TextFormField(
                          initialValue: player.name == ''
                              ? null
                              : player.name!.capitalize!,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: inputDecoration(hint: 'Jonah'),
                          onChanged: (value) {
                            setState(() {
                              player.name = value;
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
                          decoration: inputDecoration(hint: '14'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: (index == players.length - 1)
                              ? TextInputAction.done
                              : TextInputAction.next,
                          onChanged: (value) {
                            setState(() {
                              player.age = int.parse(value);
                            });
                          },
                        ),
                      ).marginOnly(right: 10),
                    ],
                  ).marginOnly(bottom: 7);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
