import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/ui/screens/new_list_screen.dart';
import 'package:todo_app_flutter/ui/screens/new_task_screen.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton>
    with SingleTickerProviderStateMixin {
  bool toggle = true;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );
    _sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Alignment alignment1 = const Alignment(0.3, -0.4);
  double size1 = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: toggle
                ? const Duration(milliseconds: 275)
                : const Duration(milliseconds: 875),
            alignment: alignment1,
            curve: toggle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 275),
              opacity: toggle ? 0.0 : 1.0,
              child: Container(
                width: 220,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _contentButton(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.rotate(
              angle: _sizeAnimation.value * pi * (3 / 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 375),
                curve: Curves.easeOut,
                height: toggle ? 70 : 60,
                width: toggle ? 70 : 60,
                decoration: BoxDecoration(
                  color: toggle ? Colors.white : Colors.blue,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (toggle) {
                          toggle = !toggle;
                          _controller.forward();
                          Future.delayed(const Duration(milliseconds: 10), () {
                            alignment1 = const Alignment(-0.1, -0.2);
                          });
                        } else {
                          toggle = !toggle;
                          _controller.reverse();
                          alignment1 = const Alignment(0.3, -0.4);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 27,
                      color: !toggle ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _contentButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              IconButton(
                color: const Color(0xFF006CFF),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => TaskFormWidget()));
                },
                icon: const Icon(Icons.done_outline),
              ),
              const SizedBox(width: 8),
              const Text("Task",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF006CFF),
                  ),
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.dns),
                color: const Color(0xFF006CFF),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ListFormWidget()));
                },
              ),
              const SizedBox(width: 8),
              const Text("List",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF006CFF),
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showListForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'List Name'),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'List Color'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
