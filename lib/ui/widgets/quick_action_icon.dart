import 'package:flutter/material.dart';

class QuickActionIcon extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;
  const QuickActionIcon({super.key, required this.icon, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: icon,
      ),
    );
  }
}
