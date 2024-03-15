// import 'package:flutter/material.dart';
// import '../../data/_data.dart';
// import '../../ui_kit/_ui_kit.dart';
//
// class ColoredDot extends StatelessWidget {
//   final TaskCategory category;
//
//   ColoredDot({required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     Color dotColor = _getCategoryColor(category);
//
//     return Container(
//       width: 12,
//       height: 12,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: dotColor,
//       ),
//     );
//   }
//
//   Color _getCategoryColor(TaskCategory category) {
//     switch (category) {
//       case TaskCategory.inbox:
//         return LightThemeColor.primaryLight;
//       case TaskCategory.work:
//         return LightThemeColor.green;
//       case TaskCategory.shopping:
//         return LightThemeColor.red;
//       case TaskCategory.family:
//         return LightThemeColor.yellow;
//       case TaskCategory.personal:
//         return LightThemeColor.purple;
//     }
//   }
// }