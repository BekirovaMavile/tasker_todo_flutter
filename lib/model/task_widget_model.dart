import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/models/list.dart';
import '../ui/screens/new_task_screen.dart';

class TasksWidgetModel extends ChangeNotifier{
  int listKey;
  late final Future<Box<Lists>> _listBox;
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

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    _listBox = Hive.openBox<Lists>('list_box');
    _loadList();
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