import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  Color? color;

  // @HiveField(2)
  // HiveList<Task>? tasks;

  Group({required this.name, required this.color});

  // void addTask(Box<Task> box, Task task) {
  //   tasks ??= HiveList(box);
  //   tasks?.add(task);
  //   save();
  // }
}
