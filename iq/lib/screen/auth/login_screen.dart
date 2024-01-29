import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/firebase_auth.dart';
import '../../constants/constants.dart';
import '../../theme/input_decoration.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RxBool show = false.obs;
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logoWidget().marginOnly(bottom: 50),
              Headline('Sign In'.tr, fontsize: 25),
              BodyText('Welcome Back'.tr).marginOnly(bottom: height * 0.05),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration(hint: 'Email'.tr, label: 'Email'.tr),
                validator: (val) {
                  if (val!.isEmpty) {
                    return '*Required'.tr;
                  } else if (!GetUtils.isEmail(val.trim())) {
                    return 'Please enter a valid email address'.tr;
                  }
                  return null;
                },
              ).marginOnly(bottom: 15),
              Obx(() {
                return TextFormField(
                  controller: password,
                  obscureText: !show.value,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: decoration(
                    hint: 'Password'.tr,
                    label: 'Password'.tr,
                    suffix: IconButton(
                      onPressed: () => show.value = !show.value,
                      icon: Icon(show.value ? Icons.lock : Icons.lock_open),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*Required'.tr;
                    }
                    return null;
                  },
                );
              }).marginOnly(bottom: 5),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Get.to(() => ForgetPassScreen()),
                  child: BodyText(
                    'Forget Password?'.tr,
                    color: AppColors.primary1,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Login'.tr,
            onPressed: () async {
              Get.focusScope!.unfocus();
              form.currentState!.save();
              if (form.currentState!.validate()) {
                await login(email.text.trim(), password.text.trim());
              }
            },
          ).marginOnly(bottom: 10, left: 10, right: 10),
        ],
      ).marginOnly(left: 25, right: 25, bottom: 10),
    );
  }
}
