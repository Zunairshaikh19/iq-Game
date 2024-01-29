import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../model/app_model.dart';
import '../model/challenges.dart';
import '/services/user_services.dart';
import '/constants/constants.dart';
import '../model/games.dart';
import '../model/questionair.dart';
import 'custom_images.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.tab,
    required this.selected,
    this.ontap,
  });
  final AppModel tab;
  final bool selected;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary1 : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary1),
        ),
        child: BodyText(
          tab.title,
          align: TextAlign.center,
          color: selected ? Colors.white : AppColors.primary1,
        ),
      ),
    );
  }
}

class ModuleIcon extends StatelessWidget {
  const ModuleIcon({required this.title, this.color, super.key});
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Center(
          child: Card(
            margin: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: width * 0.4,
              child: Center(
                child: Headline(
                  title[0].toUpperCase(),
                  fontsize: 120,
                  font: AppStrings.colaberate,
                  color: color ?? Colors.black,
                ),
              ),
            ),
          ),
        ),
        Text(
          title.capitalize!,
          style: Get.textTheme.displayLarge!.copyWith(
            fontSize: 25,
            color: color ?? Colors.black,
          ),
        ).marginOnly(bottom: 20),
      ],
    );
  }
}

class ChallengeTile extends StatelessWidget {
  const ChallengeTile({
    super.key,
    required this.challenge,
    required this.onTap,
  });
  final Challenges challenge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TitleTile(
        icon: challenge.name![0].toUpperCase(),
        title: (challenge.name ?? '').capitalize!,
        color: challenge.color == 0 ? Colors.black : Color(challenge.color!),
      ),
    );
  }
}

EdgeInsetsGeometry get pageMargin =>
    const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

Widget fieldLabel(String title) {
  return Headline(title, fontsize: 17).marginOnly(bottom: 5);
}

class QuestionairTile extends StatelessWidget {
  const QuestionairTile(
      {super.key, required this.questionair, required this.onTap});
  final Questionair questionair;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TitleTile(
        icon: questionair.name![0].toUpperCase(),
        title: (questionair.name ?? '').capitalize!,
        color:
            questionair.color == 0 ? Colors.black : Color(questionair.color!),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key, required this.title, required this.selected, this.onPressed});
  final String title;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        onPressed: onPressed ?? () {},
        icon: selected
            ? const Icon(Icons.check_box, color: AppColors.accent)
            : const Icon(Icons.check_box_outline_blank),
      ),
      title: BodyText(GetStringUtils(title).capitalize!, fontsize: 16),
    );
  }
}

class GameTile extends StatelessWidget {
  const GameTile({super.key, required this.game, required this.ontap});
  final Games game;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: TitleTile(
        icon: game.search!.first.toUpperCase(),
        title: (game.name ?? '').capitalize!,
        color: Color(game.color!),
        locked: game.premium!
            ? Get.find<UserServices>().premium
                ? false
                : true
            : false,
      ),
    );
  }
}

class TitleTile extends StatelessWidget {
  const TitleTile({
    super.key,
    required this.icon,
    required this.title,
    this.locked = false,
    required this.color,
  });
  final String icon, title;
  final bool locked;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 7),
              child: SizedBox(
                width: width,
                child: Center(
                  child: Headline(
                    icon,
                    fontsize: 80,
                    font: AppStrings.colaberate,
                    color: color,
                  ),
                ),
              ),
            ),
            RichText(
              maxLines: 2,
              text: TextSpan(
                text: title[0],
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                  color: color,
                ),
                children: [
                  TextSpan(
                    text: title.substring(1),
                    style: Get.textTheme.bodyLarge!.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (locked) const Positioned(top: 0, right: 0, child: Icon(Icons.lock)),
      ],
    );
  }
}

Center logoWidget() => Center(
      child: assetImage(
        AppIcons.logo,
        height: 150,
        color: AppColors.primary1,
      ),
    );

Container svgIcon(String icon) {
  return Container(
    width: 15,
    height: 15,
    margin: const EdgeInsets.only(left: 15, right: 10),
    child: SvgPicture.asset(icon),
  );
}

CircleAvatar profileIcon(String path, [double radius = 70]) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: providerImage(path),
    backgroundColor: Colors.transparent,
  );
}

class Headline extends StatelessWidget {
  const Headline(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.align,
    this.font,
    this.weight,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final TextAlign? align;
  final String? font;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: fontsize ?? 20,
            color: color ?? Colors.black,
            fontFamily: font,
            fontWeight: weight ?? FontWeight.bold,
          ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: fontsize ?? 14,
            color: color ?? Colors.black,
            fontWeight: weight ?? FontWeight.normal,
            fontFamily: font,
          ),
    );
  }
}

RichText authText({
  required String title,
  required String value,
  VoidCallback? onTap,
}) {
  return RichText(
    text: TextSpan(
      text: title,
      style: Get.textTheme.bodyLarge!.copyWith(),
      children: [
        TextSpan(
          text: value,
          style: Get.textTheme.bodyLarge!.copyWith(color: AppColors.accent),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}
