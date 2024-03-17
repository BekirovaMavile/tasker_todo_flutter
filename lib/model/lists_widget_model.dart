import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/models/list.dart';
import 'package:todo_app_flutter/ui/widgets/task.dart';

import '../data/_data.dart';

class ListWidgetModel extends ChangeNotifier{
  var _list = <Lists>[];

  List<Lists> get list => _list.toList();
  ListWidgetModel(){
    _setup();
  }

  void showTasks(BuildContext context, int listIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    final box = await Hive.openBox<Lists>('list_box');
    final listKey = box.keyAt(listIndex) as int;

    unawaited(
        Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TasksWidget(),
      settings: RouteSettings(
        arguments: listKey,
      ),
    )));
  }

  Future<int> getTaskCount(int index) async {
    final box = await Hive.openBox<Lists>('list_box');
    final lists = box.getAt(index);
    if (lists != null && lists.tasks != null) {
      return lists.tasks!.length;
    } else {
      return 0;
    }
  }

  void deleteList(int listIndex) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    final box = await Hive.openBox<Lists>('list_box');
    await box.getAt(listIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(listIndex);
  }

  void _readListsFromHive(Box<Lists> box) {
    _list = box.values.toList();
    notifyListeners();
  }


  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    final box = await Hive.openBox<Lists>('list_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('tasks_box');
    _readListsFromHive(box);
    box.listenable().addListener(() => _readListsFromHive(box));
  }
}

class ListWidgetModelProvider extends InheritedNotifier {
  final ListWidgetModel model;
  const ListWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    notifier: model,
    child: child,
  );

  static ListWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ListWidgetModelProvider>();
  }

  static ListWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListWidgetModelProvider>()
        ?.widget;
    return widget is ListWidgetModelProvider ? widget : null;
  }
}