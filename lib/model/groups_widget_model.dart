import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/models/group.dart';
import 'package:todo_app_flutter/ui/widgets/task.dart';
import '../data/_data.dart';


class GroupWidgetModel extends ChangeNotifier{
  var _group = <Group>[];
  List<Group> get group => _group.toList();

  GroupWidgetModel(){
    _setup();
  }

  void showTasks(BuildContext context, int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('list_box');
    final groupKey = box.keyAt(groupIndex) as int;

    unawaited(
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TasksWidget(),
          settings: RouteSettings(
            arguments: groupKey,
          ),
        )));
  }

  Future<int> getTaskCount(int index) async {
    final box = await Hive.openBox<Group>('list_box');
    final group = box.getAt(index);
    if (group != null && group.tasks != null) {
      return group.tasks!.length;
    } else {
      return 0;
    }
  }

  void deleteGroup(int groupIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('list_box');
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  void _readGroupFromHive(Box<Group> box) {
    _group = box.values.toList();
    notifyListeners();
  }



  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('list_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('tasks_box');
    // if (!Hive.isAdapterRegistered(3)) {
    //   Hive.registerAdapter(ColorAdapter());
    // }

    _readGroupFromHive(box);
    box.listenable().addListener(() => _readGroupFromHive(box));
  }
}

class GroupWidgetModelProvider extends InheritedNotifier {
  final GroupWidgetModel model;
  const GroupWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    notifier: model,
    child: child,
  );

  static GroupWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupWidgetModelProvider>();
  }

  static GroupWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupWidgetModelProvider>()
        ?.widget;
    return widget is GroupWidgetModelProvider ? widget : null;
  }
}