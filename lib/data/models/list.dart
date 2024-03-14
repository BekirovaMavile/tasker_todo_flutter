import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'list.g.dart';

@HiveType(typeId: 1)
class Lists {
  @HiveField(0)
  String name;
  Color color;

  Lists({required this.name, required this.color});
}
