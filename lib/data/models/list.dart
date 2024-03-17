import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'task.dart';

part 'list.g.dart';

@HiveType(typeId: 1)
class Lists extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  Color color;

  @HiveField(2)
  HiveList<Task>? tasks;

  Lists({required this.name, required this.color});

  void addTask(Box<Task> box, Task task) {
    tasks ??= HiveList(box);
    tasks?.add(task);
    save();
  }
}
