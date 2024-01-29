// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../constants/constants.dart';
// import '../../widgets/custom_buttons.dart';
// import '../../widgets/custom_widgets.dart';
// import 'choose_player.dart';

// class ExtraScreen extends StatelessWidget {
//   const ExtraScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Headline('Select an option')),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           CustomTextButton(
//             title: 'Play game',
//             weight: FontWeight.bold,
//             fontsize: 20,
//             onpressed: () => Get.off(() => const ChoosePlayers()),
//           ),
//         ],
//       ).marginOnly(bottom: 10),
//       body: GridView.count(
//         crossAxisCount: 2,
//         mainAxisSpacing: 15,
//         crossAxisSpacing: 10,
//         childAspectRatio: 3.5,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 10,
//         ),
//         children: List.generate(
//           extraOptions.length,
//           (index) {
//             return CheckboxListTile(
//               value: index % 2 == 0 ? true : false,
//               activeColor: AppColors.accent,
//               onChanged: (value) {},
//               title: BodyText(
//                 extraOptions[index].title.capitalize!,
//                 fontsize: 17,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }