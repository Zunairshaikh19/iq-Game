import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/firebase_auth.dart';
import '../../constants/constants.dart';
import '../../theme/input_decoration.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_images.dart';
import '../../widgets/custom_widgets.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: assetImage(AppIcons.forget, height: 250),
              ).marginOnly(bottom: 50),
              const Headline('Forgot your password?', fontsize: 23)
                  .marginOnly(bottom: 7),
              BodyText(
                'You\'ll receive a link to reset your password'.tr,
                align: TextAlign.center,
              ).marginOnly(bottom: 50),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: 'Send link'.tr,
            onPressed: () async {
              Get.focusScope!.unfocus();
              form.currentState!.save();
              if (form.currentState!.validate()) {
                await forgetPassword(email.text.trim());
              }
            },
          ),
        ],
      ).marginOnly(left: 20, right: 20, bottom: 15),
    );
  }
}
