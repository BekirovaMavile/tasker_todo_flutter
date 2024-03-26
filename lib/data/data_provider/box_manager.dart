import 'package:hive/hive.dart';
import 'package:todo_app_flutter/data/_data.dart';
import 'package:todo_app_flutter/data/models/group.dart';

class BoxManager{
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  Future<Box<Group>> openGroupBox() async {
    return _openBox('list_box', 1, GroupAdapter());
  }

  Future<Box<Task>> openTasksBox(int groupKey) async {
    return _openBox(makeTaskBoxName(groupKey), 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  String makeTaskBoxName(int groupKey) => 'tasks_box$groupKey';

  Future<Box<T>> _openBox<T>(
      String name,
      int typeId,
      TypeAdapter<T> adapter,
      ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}