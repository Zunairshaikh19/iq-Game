import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/constants.dart';
import '/widgets/custom_buttons.dart';
import '/widgets/custom_widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CustomElevatedButton(
        text: 'Purchase for \$2.99',
        onPressed: () {},
      ).marginOnly(left: 20, right: 20, bottom: 15),
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
        const Positioned(top: 0, right: 0, child: Icon(Icons.lock)),
      ],
    );
  }
}
