import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/_data.dart';
import '../data/models/list.dart';
import '../ui/screens/new_task_screen.dart';

class TasksWidgetModel extends ChangeNotifier{
  int listKey;
  late final Future<Box<Lists>> _listBox;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Lists? _list;
  Lists? get list => _list;

  TasksWidgetModel({required this.listKey}){
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TaskFormWidget(),
      settings: RouteSettings(
        arguments: listKey,
      ),
    ));
  }
  
  void _loadList() async {
    final box = await _listBox;
    _list = box.get(listKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _list?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _listBox;
    _readTasks();
    box.listenable(keys: <dynamic>[listKey]).addListener(_readTasks);
  }

  void deleteTask(int listIndex) async {
    await _list?.tasks?.deleteFromHive(listIndex);
    await _list?.save();
  }

  void doneToggle(int listIndex) async {
    final task =  list?.tasks?[listIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    _listBox = Hive.openBox<Lists>('list_box');
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