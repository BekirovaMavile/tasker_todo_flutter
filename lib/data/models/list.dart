import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'list.g.dart';

@HiveType(typeId : 1)

class List{
  @HiveField(0)
  String name;
  Color color;

  List({required this.name, required this.color});
}