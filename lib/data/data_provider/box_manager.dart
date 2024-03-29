import 'package:hive/hive.dart';
import 'package:todo_app_flutter/data/_data.dart';
import 'package:todo_app_flutter/data/models/group.dart';

class BoxManager{
  static final BoxManager instance = BoxManager._();
  // final Map<String, int> _boxCounter = <String, int>{};
  BoxManager._();

  Future<Box<Group>> openGroupBox() async {
    return _openBox('list_box', 1, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox() async {
    return _openBox('tasks_box', 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    // if (!box.isOpen) {
    //   _boxCounter.remove(box.name);
    //   return;
    // }
    // final count = _boxCounter[box.name] ?? 1;
    // _boxCounter[box.name] = count - 1;
    // if (count > 0) return;
    //
    // _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
      String name,
      int typeId,
      TypeAdapter<T> adapter,
      ) async {
    // if (Hive.isBoxOpen(name)) {
    //   final count = _boxCounter[name] ?? 1;
    //   _boxCounter[name] = count + 1;
    //   return Hive.box(name);
    // }
    // _boxCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
