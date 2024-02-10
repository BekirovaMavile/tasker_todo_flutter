import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_flutter/ui/widgets/floating_action_button.dart';

class QuickActionMenu extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final Color backgroundColor;
  final Widget child;

  const QuickActionMenu({
    super.key,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.child});

  @override
  State<QuickActionMenu> createState() => _QuickActionMenuState();
}

class _QuickActionMenuState extends State<QuickActionMenu> {
  var _isOpen = false;

  _open(){
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = true;
    });
  }

  _close(){
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        widget.child,
        Padding(
            padding: const EdgeInsets.all(16.0)
                .copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
            child: FloatingActionButtons(
                open: _open,
                close: _close,
                onTap: widget.onTap,
                isOpen: _isOpen,
                icon: widget.icon,
                backgroundColor: widget.backgroundColor),
        ),
      ],
    );
  }
}
