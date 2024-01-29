import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iq/backend/firebase_auth.dart';
import 'package:iq/screen/profile/user_profile.dart';
import 'package:iq/services/user_services.dart';
import 'package:share_plus/share_plus.dart';

import '/backend/dynamic_links.dart';
import '/controllers/dashboard_controller.dart';
import '/constants/constants.dart';
import '/widgets/custom_buttons.dart';
import '/widgets/custom_images.dart';
import '/widgets/custom_widgets.dart';
import 'about_screen.dart';
import 'payment_screen.dart';
import 'submit_your_own.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: height * 0.3,
            child: DrawerHeader(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ).marginOnly(bottom: 10),
                  InkWell(
                    onTap: () {
                      if (Get.find<UserServices>().anonymous == false) {
                        Get.to(() => const UserProfileScreen());
                      }
                    },
                    child: Card(
                      elevation: 10.0,
                      child: ClipRRect(
                        child: CustomImageWidget(
                          image: Get.find<UserServices>().anonymous
                              ? AppIcons.icon
                              : Get.find<UserServices>().user.profile ?? '',
                          width: 90,
                          height: 80,
                          color: Colors.black,
                        ).marginOnly(top: 10, bottom: 10, left: 10, right: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawerTile(
            title: 'Home',
            icon: const Icon(Icons.home),
            ontap: () => Get.back(),
          ),
          drawerTile(
            title: 'Games',
            icon: const Icon(Icons.play_circle),
            ontap: () => {
              Get.back(),
              Get.find<DashboardController>().controller.animateTo(
                    Get.find<DashboardController>()
                        .controller
                        .position
                        .minScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  ),
            },
          ),
          drawerTile(
            title: 'Challenges',
            icon: const Icon(Icons.menu_open_outlined),
            ontap: () => {
              Get.back(),
              Get.find<DashboardController>().controller.animateTo(
                    Get.find<DashboardController>()
                        .controller
                        .position
                        .maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  ),
            },
          ),
          // drawerTile(
          //   title: 'Extras',
          //   icon: const Icon(Icons.fullscreen_exit_outlined),
          //   ontap: () => {Get.back(), Get.off(() => const ExtraScreen())},
          // ),
          drawerTile(
            title: 'Submit Your Own',
            icon: const Icon(Icons.question_answer_outlined),
            ontap: () {
              Get.back();
              Get.to(() => const SubmitScreen());
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) {
              //     return Padding(
              //       padding: const EdgeInsets.only(
              //         top: 10,
              //         bottom: 20,
              //         left: 15,
              //         right: 15,
              //       ),
              //       child: Column(
              //         children: [
              //           InkWell(
              //             onTap: () => Get.back(),
              //             child: SvgPicture.asset(AppIcons.back),
              //           ),
              //           const Spacer(),
              //           CustomElevatedButton(
              //             radius: 30,
              //             btnHeight: 50,
              //             btnWidth: 250,
              //             text: 'Submit Questions',
              //             onPressed: () => {
              //               Get.back(),
              //               Get.to(() => const SubmitQuestion()),
              //             },
              //           ).marginOnly(bottom: 30),
              //           CustomElevatedButton(
              //             radius: 30,
              //             btnHeight: 50,
              //             btnWidth: 250,
              //             text: 'Submit Challenges',
              //             onPressed: () => {
              //               Get.back(),
              //               Get.to(() => const SubmitChallenge()),
              //             },
              //           ),
              //           const Spacer(),
              //         ],
              //       ),
              //     );
              //   },
              // );
            },
          ),
          drawerTile(
            title: 'About',
            icon: const Icon(Icons.info_outline),
            ontap: () => {Get.back(), Get.to(() => const AboutScreen())},
          ),
          drawerTile(
            isLast: !Get.find<UserServices>().isAuth,
            title: 'Share Application',
            icon: const Icon(Icons.share),
            ontap: () async => {
              Get.back(),
              Share.share(await generateDynamicLinks('appid')!),
            },
          ),
          if (Get.find<UserServices>().isAuth &&
              Get.find<UserServices>().anonymous == false)
            drawerTile(
              title: 'Logout',
              icon: const Icon(Icons.logout),
              ontap: () async => await logout(),
            ),
          InkWell(
            onTap: () => {},
            child: Card(
              elevation: 10.0,
              color: Colors.white,
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.01),
                    const Headline('Access All Games'),
                    SizedBox(height: height * 0.02),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        title: '\$ 2.99',
                        onpressed: () => Get.to(() => const PaymentScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  drawerTile({
    bool isLast = false,
    Widget? icon,
    required String title,
    VoidCallback? ontap,
  }) {
    return InkWell(
      onTap: ontap ?? () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: icon,
            title: BodyText(title),
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
          ),
          if (!isLast) const Divider(),
        ],
      ),
    );
  }
}
