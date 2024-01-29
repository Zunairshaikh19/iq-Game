import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../widgets/custom_widgets.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Headline('Challenges')),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: List.generate(
          6,
          (index) => gameTile(
            width,
            index,
            alphabets[index],
          ),
        ),
      ),
    );
  }

  gameTile(double width, int index, String name) {
    return InkWell(
      // onTap: () => Get.to(
      //   () => GameLandingPage(color: colors[index],),
      // ),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 7),
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: Headline(
                      name,
                      fontsize: 80,
                      font: AppStrings.colaberate,
                      color: colors[index],
                    ),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: name,
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: 15,
                    color: colors[index],
                  ),
                  children: [
                    TextSpan(
                      text: ' challenge',
                      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
              // BodyText('$name Game ', fontsize: 15),
            ],
          ),
          const Positioned(top: 0, right: 0, child: Icon(Icons.lock)),
        ],
      ),
    );
  }
}
