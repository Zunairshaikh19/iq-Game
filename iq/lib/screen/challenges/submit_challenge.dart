import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_widgets.dart';
import '../../constants/constants.dart';
import '../../theme/input_decoration.dart';
import '../../widgets/custom_buttons.dart';

class SubmitChallenge extends StatelessWidget {
  const SubmitChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Headline('Submit Your Own').marginOnly(bottom: 5),
              const BodyText(
                'You can submit your challenge here and as long as the administration goes through your questions. They will add it into the database',
                color: AppColors.textSecondary,
              ).marginOnly(bottom: 30),
              const Headline('Name', fontsize: 17).marginOnly(bottom: 5),
              TextFormField(
                decoration: decoration(
                  hint: 'Enter your name',
                  label: 'Enter your name',
                ),
              ).marginOnly(bottom: 10),
              const Headline('Select theme'),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 3.5,
                children: List.generate(
                  playOptions.length,
                  (index) {
                    return CheckboxListTile(
                      value: index % 2 == 0 ? true : false,
                      activeColor: AppColors.secondary,
                      onChanged: (value) {},
                      title: BodyText(
                        playOptions[index].title.capitalize!,
                        fontsize: 17,
                      ),
                    );
                  },
                ),
              ).marginOnly(bottom: 5),
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Headline('How many players?'),
                    trailing: DropdownButton<int>(
                      value: 2,
                      alignment: Alignment.center,
                      items: <int>[1, 2, 3, 4]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: BodyText(e.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {},
                    ),
                  ),

                ],
              ),
              SizedBox(height: height * 0.07),
              const Headline(
                'Tell us why should we approve this challenge?',
                fontsize: 17,
              ).marginOnly(bottom: 5),
              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: decoration(
                  hint: 'Why do you choose these questions\n\n\n\n\n',
                ),
              ).marginOnly(bottom: height * 0.1),
              CustomElevatedButton(
                text: 'Submit Challenge',
                onPressed: () {},
              ).marginOnly(left: 15, right: 15, bottom: 20),
            ],
          ),
        ),
      ),
    );
  }
}
