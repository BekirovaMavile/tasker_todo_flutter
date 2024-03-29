import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/data_provider/box_manager.dart';
import 'package:todo_app_flutter/data/models/group.dart';
import 'package:todo_app_flutter/ui/widgets/task.dart';
import '../data/_data.dart';

class GroupWidgetModel extends ChangeNotifier{
  late final Future<Box<Group>> _box;
  // ValueListenable<Object>? _listenableBox;
  var _group = <Group>[];
  List<Group> get group => _group.toList();

  GroupWidgetModel(){
    _setup();
  }

  Future<void> showTasks(BuildContext context, int listIndex) async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    // final box = await BoxManager.instance.openGroupBox();
    final groupKey = (await _box).keyAt(listIndex) as int;

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

  Future<void> deleteGroup(int groupIndex) async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    final box = await _box;
    // final box = await BoxManager.instance.openGroupBox();
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);

    // await box.deleteFromDisk();
  }

  Future<void> _readListsFromHive() async {
    _group = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final box = await Hive.openBox<Group>('list_box');
    _box = BoxManager.instance.openGroupBox();
    //
    // if (!Hive.isAdapterRegistered(2)) {
    //   Hive.registerAdapter(TaskAdapter());
    // }
    // await Hive.openBox<Task>('tasks_box');
    await BoxManager.instance.openTaskBox();
    await _readListsFromHive();
    // _listenableBox = (await _box).listenable();
    (await _box).listenable().addListener(_readListsFromHive);

  }
  //
  // @override
  // Future<void> dispose() async {
  //   _listenableBox?.removeListener(_readListsFromHive);
  //   await BoxManager.instance.closeBox((await _box));
  //   super.dispose();
  // }
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