import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/list.dart';

class ListFormWidgetModel {
  var listName = '';
  String listColor = '';

  void saveList(BuildContext context) async {
    if (listName.isEmpty && listColor.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListAdapter());
    }
    final box = await Hive.openBox<List>('list_box');
    final list = List(name: listName, color: listColor);
    await box.add(list);
    Navigator.of(context).pop();
    // print(listName);
  }
}

class ListFormWidgetModelProvider extends InheritedWidget {
  final ListFormWidgetModel model;
  const ListFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    child: child,
  );

  static ListFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ListFormWidgetModelProvider>();
  }

  static ListFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListFormWidgetModelProvider>()
        ?.widget;
    return widget is ListFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ListFormWidgetModelProvider oldWidget) {
    return true;
  }
}