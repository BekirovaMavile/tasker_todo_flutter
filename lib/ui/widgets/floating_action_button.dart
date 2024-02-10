import 'package:flutter/material.dart';
import 'package:todo_app_flutter/ui/widgets/quick_action_icon.dart';

class FloatingActionButtons extends StatefulWidget {
  final Function() open;
  final Function() close;
  final Function() onTap;
  final bool isOpen;
  final IconData icon;
  final Color backgroundColor;

  const FloatingActionButtons({
    super.key,
    required this.open,
    required this.close,
    required this.onTap,
    required this.isOpen,
    required this.icon,
    required this.backgroundColor
  });

  @override
  State<FloatingActionButtons> createState() => _FloatingActionButtonsState();
}

class _FloatingActionButtonsState extends State<FloatingActionButtons> {
  final _duration = const Duration(microseconds: 200);
  var _isPressed = false;

  _pressDown(){
    setState(() {
      _isPressed = true;
    });
  }

  _pressUp(){
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressDown(),
      onTapUp: (_) => _pressUp(),
      onTapCancel: () => _pressUp(),
      onTap: () => widget.isOpen ? widget.close() : widget.onTap(),
      onLongPress: () {
        if(!widget.isOpen) {
          widget.open();
          _pressUp();
        }
      },
      child: AnimatedScale(
        scale: _isPressed || widget.isOpen ? 0.8 : 1,
        duration: _duration,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
                color: Colors.black26,
              ),
            ],
          ),
          child: Stack(
            children: [
              QuickActionIcon(
                  icon: Icon(
                    Icons.close_rounded,
                    color: widget.backgroundColor,
                    size: 24,
                  ),
                  backgroundColor: Colors.white
              ),
              AnimatedOpacity(
                opacity: widget.isOpen ? 0 : 1,
                duration: _duration,
                child: QuickActionIcon(
                    icon: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                    backgroundColor: widget.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

