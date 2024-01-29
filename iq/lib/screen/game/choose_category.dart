// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/app_services.dart';
import '../../constants/ui.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import 'choose_player.dart';

class ChooseCategory extends StatelessWidget {
  ChooseCategory({super.key});
  RxList<int> selected = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Headline('Select an option')),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextButton(
              title: 'Play game',
              weight: FontWeight.bold,
              fontsize: 20,
              onpressed: () {
                if (selected.isNotEmpty) {
                  Get.off(() => ChoosePlayers(categories: selected));
                } else {
                  Get.showSnackbar(
                    Ui.ErrorSnackBar(
                      message: 'Please select atleast on category first',
                    ),
                  );
                }
              },
            ),
          ],
        ).marginOnly(bottom: 10),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          childAspectRatio: 3.5,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          children: List.generate(
            Get.find<AppServices>().categories.length,
            (index) {
              final category = Get.find<AppServices>().categories[index];
              return CustomCheckbox(
                title: category.title,
                selected:
                    selected.isNotEmpty && selected.contains(category.value),
                onPressed: () {
                  if (selected.isNotEmpty &&
                      selected.contains(category.value)) {
                    selected.remove(category.value);
                  } else {
                    selected.add(category.value);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
