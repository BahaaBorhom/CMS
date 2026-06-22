// import 'package:cms/core/constants/font_heading.dart';
// import 'package:flutter/material.dart';

// class SginupScreen extends StatelessWidget {
//   const SginupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( appBar: AppBar(
//   leading: IconButton(
//     onPressed: () {
//       Navigator.pop(context);
//     },
//     icon: const Icon(Icons.arrow_back),
//   ),
//   title: const Text("Back"),
//   titleSpacing: 0, // Removes space between back icon and text
//   actions: [
//     Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(
//             Icons.arrow_drop_down,
//             color: Colors.black,
//           ),
//           const SizedBox(width: 4),
//           DropdownButton<String>(
//             value: state.selectedLanguage,
//             icon: const SizedBox(),
//             underline: const SizedBox(),
//             style: FontHeading.body.copyWith(
//               color: Colors.black,
//             ),
//             items: state.languages.map((String language) {
//               return DropdownMenuItem<String>(
//                 value: language,
//                 child: Text(language),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 context
//                     .read<LanguageCubit>()
//                     .changeLanguage(newValue);
//               }
//             },
//           ),
//         ],
//       ),
//     ),
//   ],
// ),);
//   }
// }