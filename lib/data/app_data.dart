import 'package:flutter/material.dart';
import '_data.dart';

class AppData {
  AppData._();

  static List<Task> tasks = [
    Task("Start making a presentation", TaskCategory.work),
    Task("Pay for rent", TaskCategory.personal),
    Task("Buy a milk", TaskCategory.shopping),
    Task("Don’t forget to pick up Mickael from \nschool", TaskCategory.inbox),
    Task("Buy a chocolate for Charlotte", TaskCategory.shopping),
  ];

  static List<TaskCategory> categories = [
    TaskCategory.inbox,
    TaskCategory.work,
    TaskCategory.shopping,
    TaskCategory.family,
    TaskCategory.personal,
  ];
}