import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/firebase_auth.dart';
import '../../model/users.dart';
import '../../theme/input_decoration.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_widgets.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repeat = TextEditingController();
  final RxBool show = false.obs;
  final RxBool rshow = false.obs;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        // backgroundColor: const Color(0xffFEBDD0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoWidget(),
                Headline('Sign Up'.tr),
                BodyText('It only takes a minute to create your account'.tr)
                    .marginOnly(bottom: height * 0.1),
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: decoration(hint: 'Name'.tr, label: 'Name'.tr),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*Required'.tr;
                    }
                    return null;
                  },
                ).marginOnly(bottom: 15),
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
                TextFormField(
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
                ).marginOnly(bottom: 15),
                TextFormField(
                  controller: repeat,
                  obscureText: !rshow.value,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: decoration(
                    hint: 'Repeat Password'.tr,
                    label: 'Repeat Password'.tr,
                    suffix: IconButton(
                      onPressed: () => rshow.value = !rshow.value,
                      icon: Icon(rshow.value ? Icons.lock : Icons.lock_open),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return '*Required'.tr;
                    } else if (val != password.text) {
                      return 'Password don\'t match'.tr;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              text: 'Register'.tr,
              onPressed: () async {
                Get.focusScope!.unfocus();
                form.currentState!.save();
                if (form.currentState!.validate()) {
                  final user = UserModel(
                    name: name.text,
                    email: email.text.trim(),
                    password: password.text,
                  );
                  await signUp(user);
                }
              },
            ).marginOnly(bottom: 10, left: 10, right: 10),
            authText(
              title: 'Already have an account? '.tr,
              value: 'LOGIN'.tr,
              onTap: () => Get.to(() => LoginScreen()),
            ),
          ],
        ).marginOnly(left: 25, right: 25, bottom: 10),
      ),
    );
  }
}
