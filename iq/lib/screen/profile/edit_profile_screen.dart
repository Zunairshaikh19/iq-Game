// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/firebase_storage.dart';
import '../../../controllers/user_controller.dart';

import '../../../global/functions.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_widgets.dart';
import '../../../widgets/loading_widgets.dart';

import '../../../constants/ui.dart';

import '../../../theme/input_decoration.dart';
import '../../global/refs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final RxString profile = ''.obs;

  final UserController controller = Get.find();
  final RxBool edit = false.obs;

  setData() async {
    setState(() {
      final user = controller.user.value;
      name.text = user.name!;
      profile.value = user.profile!;
      email.text = user.email ?? '';
      password.text = user.password ?? '';
    });
  }

  updateProfile() async {
    Get.focusScope!.unfocus();
    form.currentState!.save();
    if (form.currentState!.validate()) {
      loadingDialog();
      if (name.text.isNotEmpty) controller.user.value.name = name.text;
      if (profile.value != '' &&
          (profile.value != controller.user.value.profile)) {
        controller.user.value.profile = await uploadFile(
          profile.value,
          'Users/${controller.user.value.id}',
        );
      }
      if (email.text.isNotEmpty &&
          (email.text.trim() != controller.user.value.email)) {
        await updateEmail();
      }

      if (password.text.isNotEmpty &&
          (password.text.trim() != controller.user.value.password)) {
        await updatePassword();
      }

      ///
      await userRef
          .doc(controller.user.value.id)
          .update(controller.user.value.toMap());
      await controller.getUserData(controller.user.value.id!);
      edit.value = !edit.value;
      Get.back();
      Get.showSnackbar(
        Ui.SuccessSnackBar(message: 'Profile Updated Successfully!'),
      );
    }
  }

  updatePassword() async {
    await auth
        .signInWithEmailAndPassword(
            email: controller.user.value.email!,
            password: controller.user.value.password!)
        .then((value) async {
      await value.user!.updatePassword(password.text);
      controller.user.value.password = password.text;
    });
  }

  updateEmail() async {
    await auth
        .signInWithEmailAndPassword(
            email: controller.user.value.email!,
            password: controller.user.value.password!)
        .then((value) async {
      await value.user!.updateEmail(email.text.trim());
      controller.user.value.email = email.text.trim();
    });
  }

  @override
  void initState() {
    setState(() {
      setData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          actions: [
            if (!edit.value)
              IconButton(
                onPressed: () => edit.value = !edit.value,
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        bottomNavigationBar: edit.value
            ? CustomElevatedButton(
                text: 'Update',
                onPressed: () => updateProfile(),
              ).marginOnly(left: 15, right: 15, bottom: 10)
            : const SizedBox.shrink(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      profileIcon(profile.value),
                      if (edit.value)
                        Positioned(
                          bottom: -10,
                          right: 5,
                          child: IconButton(
                            onPressed: () async {
                              final file = await pickImage();
                              if (file != '') profile.value = file;
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                    ],
                  ),
                ).marginOnly(bottom: 50),
                TextFormField(
                  controller: name,
                  readOnly: !edit.value,
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                  decoration: decoration(
                    hint: 'Full Name',
                    radius: 12,
                    fill: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ).marginOnly(bottom: 15),
                TextFormField(
                  controller: email,
                  readOnly: !edit.value,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Can\'t be empty';
                    } else if (!GetUtils.isEmail(val.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: decoration(
                    hint: 'Email Address',
                    radius: 12,
                    fill: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ).marginOnly(bottom: 15),
                TextFormField(
                  controller: password,
                  readOnly: !edit.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                  decoration: decoration(
                    hint: 'Password',
                    radius: 12,
                    fill: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ).marginOnly(bottom: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
