import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/data_provider/box_manager.dart';
import 'package:todo_app_flutter/ui/widgets/task.dart';
import '../data/_data.dart';
import '../ui/screens/new_task_screen.dart';

class TasksWidgetModel extends ChangeNotifier{
  TasksWidgetConfiguration configuration;
  late final Future<Box<Task>> _box;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();
  // Group? _group;
  // Group? get group => _group;
  TasksWidgetModel({required this.configuration}){
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TaskFormWidget(),
      settings: RouteSettings(
        arguments: configuration.groupKey,
      ),
    ));
  }
  
  // void _loadGroup() async {
  //   final box = await _groupBox;
  //   _group = box.get(groupKey);
  //   notifyListeners();
  // }

  // void _readTasks() {
  //   _tasks = _group?.tasks ?? <Task>[];
  //   notifyListeners();
  // }

  // void _setupListenTasks() async {
  //   final box = await _groupBox;
  //   _readTasks();
  //   box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  // }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);

    // await _group?.tasks?.deleteFromHive(taskIndex);
    // await _group?.save();
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();

    // final task =  group?.tasks?[listIndex];
    // final currentState = task?.isDone ?? false;
    // task?.isDone = !currentState;
    // await task?.save();
    // notifyListeners();
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }


  Future<void> _setup() async {
    _box = BoxManager.instance.openTasksBox(configuration.groupKey);
    await _readTasksFromHive();
    (await _box).listenable().addListener(_readTasksFromHive);
  }

  // void _setup() {
  //   if (!Hive.isAdapterRegistered(1)) {
  //     Hive.registerAdapter(GroupAdapter());
  //   }
  //   _groupBox = Hive.openBox<Group>('list_box');
  //   if (!Hive.isAdapterRegistered(2)) {
  //     Hive.registerAdapter(TaskAdapter());
  //   }
  //   Hive.openBox<Task>('tasks_box');
  //   _loadGroup();
  //   _setupListenTasks();
  // }
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