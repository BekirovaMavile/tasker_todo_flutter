import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'list.g.dart';

@HiveType(typeId: 1)
class Lists {
  @HiveField(0)
  String name;

  @HiveField(1)
  Color color;

  @HiveField(2)
  HiveList? tasks;

  Lists({required this.name, required this.color});
}
