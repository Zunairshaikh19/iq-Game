import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/backend/cloud_firestore.dart';
import 'package:iq/widgets/custom_buttons.dart';

import '../backend/firebase_auth.dart';
import '../global/functions.dart';
import '../model/questions.dart';
import '../model/users.dart';
import '../services/app_services.dart';
import '../theme/input_decoration.dart';
import '/constants/constants.dart';
import 'custom_widgets.dart';

resetPassDialog(BuildContext context) {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Headline('Forgot your password?', fontsize: 20)
                .marginOnly(bottom: 7),
            BodyText(
              'You\'ll receive a link to reset your password'.tr,
              align: TextAlign.center,
            ),
          ],
        ),
        content: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
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
        actions: [
          CustomElevatedButton(
            text: 'Send Link',
            btnWidth: 120,
            btnHeight: 40,
            onPressed: () async {
              Get.focusScope!.unfocus();
              form.currentState!.save();
              if (form.currentState!.validate()) {
                await forgetPassword(email.text.trim());
              }
            },
          ).marginOnly(right: 10),
          CustomOutlinedButton(
            text: 'Cancel',
            btnWidth: 90,
            btnHeight: 40,
            onPressed: () => Get.back(),
          ),
        ],
      );
    },
  );
}

Future<bool> signupDialog(
  BuildContext context, {
  Questions? question,
  Function(bool)? dialog,
}) {
  final GlobalKey<FormState> signup = GlobalKey<FormState>();
  final GlobalKey<FormState> signin = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  bool show = false;
  bool check = false;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final height = MediaQuery.of(context).size.height;
      potrait();
      return StatefulBuilder(
        builder: (context, setState) {
          Widget showButton() {
            return IconButton(
              onPressed: () => setState(() => show = !show),
              icon: Icon(show ? Icons.lock : Icons.lock_open),
            );
          }

          setCheck(bool value) {
            setState(() {
              check = value;
              debugPrint('check: $value');
            });
          }

          return DefaultTabController(
            length: 2,
            initialIndex: 1,
            child: AlertDialog(
              scrollable: true,
              actions: [
                CustomOutlinedButton(
                  text: 'Cancel',
                  onPressed: () => {landscape(), Get.back()},
                  btnWidth: 100,
                  btnHeight: 40,
                ),
              ],
              title: TabBar(
                tabs: const [Tab(text: 'Sign in'), Tab(text: 'Sign up')],
                onTap: (value) {
                  if (signin.currentState != null) signin.currentState!.reset();
                  if (signup.currentState != null) signup.currentState!.reset();
                  name.clear();
                  email.clear();
                  password.clear();
                  show = false;
                  setState(() {});
                },
              ),
              content: SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom != 0
                    ? height
                    : height * 0.5,
                child: TabBarView(
                  children: [
                    Form(
                      key: signin,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Headline('Welcome Back')
                              .marginOnly(bottom: height * 0.05),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration:
                                decoration(hint: 'Email'.tr, label: 'Email'.tr),
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
                            obscureText: !show,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: decoration(
                              hint: 'Password'.tr,
                              label: 'Password'.tr,
                              suffix: showButton(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '*Required'.tr;
                              }
                              return null;
                            },
                          ).marginOnly(bottom: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => resetPassDialog(context),
                              child: BodyText(
                                'Forget Password?'.tr,
                                color: AppColors.primary1,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomElevatedButton(
                            text: 'Sign in',
                            onPressed: () async {
                              Get.focusScope!.unfocus();
                              signin.currentState!.save();
                              final bool validate =
                                  signin.currentState!.validate();
                              try {
                                if (validate) {
                                  // loadingDialog();
                                  await login(
                                    email.text.trim(),
                                    password.text,
                                    true,
                                  ).then((value) {
                                    setCheck(value);
                                    if (value) {
                                      Get.log('logged in');
                                      if (question != null) {
                                        addFavQuestion(question);
                                      }
                                      if (dialog != null) dialog(true);
                                      if (question != null) landscape();
                                      Get.back();
                                      // Get.back();
                                    }
                                  });
                                }
                              } catch (e) {
                                if (validate) Get.back();
                                debugPrint('SignIn Error: $e');
                                throw Exception(e);
                              }
                            },
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ),
                    Form(
                      key: signup,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const BodyText(
                            'It only takes a minute to create your account',
                          ).marginOnly(bottom: height * 0.06),
                          TextFormField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration:
                                decoration(hint: 'Name'.tr, label: 'Name'.tr),
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
                            textInputAction: TextInputAction.next,
                            decoration:
                                decoration(hint: 'Email'.tr, label: 'Email'.tr),
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
                            obscureText: !show,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: decoration(
                              hint: 'Password'.tr,
                              label: 'Password'.tr,
                              suffix: showButton(),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return '*Required'.tr;
                              }
                              return null;
                            },
                          ).marginOnly(bottom: 15),
                          const Spacer(),
                          CustomElevatedButton(
                            text: 'Register'.tr,
                            onPressed: () async {
                              Get.focusScope!.unfocus();
                              signup.currentState!.save();
                              final bool validate =
                                  signup.currentState!.validate();
                              try {
                                if (validate) {
                                  final user = UserModel(
                                    name: name.text,
                                    email: email.text.trim(),
                                    password: password.text,
                                  );
                                  await signUp(user, true).then((value) {
                                    setCheck(value);
                                    if (value) {
                                      if (question != null) {
                                        addFavQuestion(question);
                                      }
                                      if (dialog != null) dialog(true);
                                      if (question != null) landscape();
                                      Get.back();
                                      // Get.back();
                                    }
                                  });
                                }
                              } catch (e) {
                                if (validate) Get.back();
                                debugPrint('Signup Error: $e');
                                throw Exception(e);
                              }
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).then((value) => check);
}

deletedDialog(String userid) {
  contactUsDialog(
    title: 'Unable to Login'.tr,
    description:
        'Looks like your account has been disabled by the admin. If you think this is a mistake you can contact the admin.'
            .tr,
    ontap: () => {logout(), Get.back()},
    cancel: () async => launchWebsite(Get.find<AppServices>().support.support!),
  );
}

contactUsDialog({
  String? description,
  VoidCallback? ontap,
  VoidCallback? cancel,
  String button = 'Okay',
  String cancelbtn = 'Contact Us',
  String title = 'Success!',
}) {
  Get.defaultDialog(
    title: title.tr,
    onCancel: cancel,
    textConfirm: button.tr,
    textCancel: cancelbtn.tr,
    middleText: description!,
    cancelTextColor: AppColors.accent,
    confirmTextColor: Colors.black,
    buttonColor: AppColors.accent,
    onConfirm: ontap ?? () => Get.back(),
    titleStyle: const TextStyle(fontFamily: AppStrings.font),
    middleTextStyle: const TextStyle(fontFamily: AppStrings.font),
    titlePadding: const EdgeInsets.only(top: 10, bottom: 15),
  );
}
