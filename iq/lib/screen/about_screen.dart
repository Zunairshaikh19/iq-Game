import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/services/app_services.dart';
import '/widgets/custom_images.dart';
import '/widgets/custom_widgets.dart';
import '/constants/constants.dart';
import '/global/refs.dart';
import '/model/faq.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const Headline('About Us', fontsize: 25).marginOnly(bottom: 5),
            BodyText(
              Get.find<AppServices>().about.about ?? '',
              color: AppColors.textSecondary,
              align: TextAlign.center,
            ).marginOnly(bottom: 20),
            const CustomImageWidget(image: AppIcons.logo, height: 150)
                .marginOnly(bottom: 30),
            StreamBuilder(
                stream: faqRef.orderBy('question').snapshots(),
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
                      const Headline('Frequently Asked Questions', fontsize: 25)
                          .marginOnly(bottom: 5),
                      const BodyText(
                        'Everything that you need to know about this application and how to play this game',
                        color: AppColors.textSecondary,
                        align: TextAlign.center,
                      ).marginOnly(bottom: 20),
                      ListView.separated(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final faq = FAQ.fromMap(snapshot.data.docs[index]);
                          return ExpansionTile(
                            trailing: const Icon(Icons.add_circle_outline),
                            title: Headline(
                              (faq.question ?? '').capitalizeFirst!,
                              fontsize: 17,
                            ),
                            childrenPadding: const EdgeInsets.all(15),
                            children: [
                              BodyText((faq.answer ?? '').capitalizeFirst!)
                            ],
                          );
                        },
                      ).marginOnly(bottom: height * 0.05),
                    ],
                  );
                }),
            const Headline('Still have questions?', fontsize: 16)
                .marginOnly(bottom: 5),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Please feel free to contact us at any time at ',
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: (Get.find<AppServices>().about.email ?? '')
                        .toLowerCase(),
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: AppColors.primary1,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary1,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ).marginOnly(bottom: 10),
          ],
        ),
      ),
    );
  }
}
