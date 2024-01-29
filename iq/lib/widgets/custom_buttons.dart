import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/theme/button_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.btnWidth,
    this.btnHeight,
    this.weight,
    this.borderColor,
    this.textColor,
    this.radius,
    this.fontsize,
    this.icon,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double? btnWidth, btnHeight, radius, fontsize;
  final FontWeight? weight;
  final Color? textColor, borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: btnWidth ?? width,
      height: btnHeight ?? 50,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: outlineButton(
          primary: borderColor ?? AppColors.primary1,
          borderColor: borderColor ?? AppColors.primary1,
          radius: radius ?? 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(),
            Padding(
              padding: EdgeInsets.only(left: icon == null ? 0 : 10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: weight ?? FontWeight.bold,
                      color: textColor ?? AppColors.primary1,
                      fontSize: fontsize ?? 15,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.btnWidth,
    this.btnHeight,
    this.weight,
    this.radius,
    this.textColor,
    this.primary,
    this.elevation,
    this.icon,
    this.fontsize,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double? btnWidth, btnHeight, radius, elevation, fontsize;
  final FontWeight? weight;
  final Color? textColor, primary;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: btnWidth ?? width,
      height: btnHeight ?? 50,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: elevatedButton(
          radius: radius ?? 10,
          primary: primary ?? AppColors.primary1,
          borderColor: primary ?? AppColors.primary1,
          elevation: elevation ?? 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(),
            Padding(
              padding: EdgeInsets.only(left: icon != null ? 10 : 0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: textColor ?? Colors.white,
                      fontWeight: weight ?? FontWeight.bold,
                      fontSize: fontsize ?? 15,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    Key? key,
    this.icon,
    required this.title,
    this.color,
    this.fontsize,
    this.weight,
    this.onpressed,
  }) : super(key: key);
  final Widget? icon;
  final String title;
  final Color? color;
  final double? fontsize;
  final FontWeight? weight;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onpressed ?? () {},
      icon: icon ?? Icon(Icons.add, color: color ?? AppColors.primary1),
      label: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontsize ?? 15,
              fontWeight: weight ?? FontWeight.bold,
              color: color ?? AppColors.primary1,
            ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.color,
    this.fontsize,
    this.weight,
    this.onpressed,
  }) : super(key: key);
  final String title;
  final Color? color;
  final double? fontsize;
  final FontWeight? weight;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed ?? () {},
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontsize ?? 15,
              fontWeight: weight ?? FontWeight.normal,
              color: color ?? AppColors.primary1,
            ),
      ),
    );
  }
}

class OptionTextButton extends StatelessWidget {
  const OptionTextButton({
    Key? key,
    required this.title,
    this.onpressed,
  }) : super(key: key);
  final String title;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onpressed ?? () {},
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

