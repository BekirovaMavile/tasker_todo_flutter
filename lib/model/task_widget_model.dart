import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/_data.dart';
import '../data/models/group.dart';
import '../ui/screens/new_task_screen.dart';

class TasksWidgetModel extends ChangeNotifier{
  int groupKey;
  late final Future<Box<Group>> _groupBox;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}){
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TaskFormWidget(),
      settings: RouteSettings(
        arguments: groupKey,
      ),
    ));
  }

  void _loadList() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  }

  void deleteTask(int listIndex) async {
    await _group?.tasks?.deleteFromHive(listIndex);
    await _group?.save();
  }

  void doneToggle(int listIndex) async {
    final task =  group?.tasks?[listIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('list_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _loadList();
    _setupListenTasks();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    notifier: model,
    child: child,
  );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}