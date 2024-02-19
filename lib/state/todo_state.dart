import 'package:flutter/material.dart';

import '../data/_data.dart';
import '../ui_kit/_ui_kit.dart';

class ToDoState {
  ToDoState._();

  static final _instance = ToDoState._();

  factory ToDoState() => _instance;

  //Переменные
  List<TaskCategory> categories = AppData.categories;

  String getCategoryName(TaskCategory category) {
    return category.toString().substring(category.toString().indexOf('.') + 1);
  }

  int getTaskCount(TaskCategory category) {
    int count = 0;
    for (Task task in AppData.tasks) {
      if (task.category == category) {
        count++;
      }
    }
    return count;
  }

  Color getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.inbox:
        return LightThemeColor.primaryLight;
      case TaskCategory.work:
        return LightThemeColor.green;
      case TaskCategory.shopping:
        return LightThemeColor.red;
      case TaskCategory.family:
        return LightThemeColor.yellow;
      case TaskCategory.personal:
        return LightThemeColor.purple;
      default:
        return Colors.grey;
    }
  }
}