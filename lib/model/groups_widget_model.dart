import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/data_provider/box_manager.dart';
import 'package:todo_app_flutter/data/models/group.dart';
import 'package:todo_app_flutter/ui/widgets/task.dart';
import '../data/_data.dart';

class GroupWidgetModel extends ChangeNotifier{
  // добавили 14 строку
  late final Future<Box<Group>> _box;

  var _group = <Group>[];

  List<Group> get group => _group.toList();
  GroupWidgetModel(){
    _setup();
  }

  Future<void> showTasks(BuildContext context, int groupIndex) async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    // final box = await BoxManager.instance.openGroupBox();
    final group = (await _box).getAt(groupIndex);
    if (group != null) {
      final configuration = TasksWidgetConfiguration(group.key as int, group.name);
      unawaited(
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TasksWidget(configuration: configuration,),
            settings: RouteSettings(
              arguments: configuration,
            ),
          )));
    }
  }

  Future<int> getTaskCount(int groupIndex) async {
    final box = await Hive.openBox<Group>('list_box');
    final group = box.getAt(groupIndex);

    if (group != null) {
      final groupKey = group.key as int;
      final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
      final taskBox = await Hive.openBox<Task>(taskBoxName);

      return taskBox.length;
    } else {
      return 0;
    }
  }


  Future<void> deleteGroup(int groupIndex) async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    final box = await _box;
    final groupKey = (await _box).keyAt(groupIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(groupKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    // await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  Future<void> _readGroupFromHive() async {
    _group = (await _box).values.toList();
    notifyListeners();
  }


  void _setup() async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    // if (!Hive.isAdapterRegistered(2)) {
    //   Hive.registerAdapter(TaskAdapter());
    // }
    // await Hive.openBox<Task>('tasks_box');
    _box = BoxManager.instance.openGroupBox();
    // await BoxManager.instance.openTasksBox();
    await _readGroupFromHive();
    (await _box).listenable().addListener(_readGroupFromHive);
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