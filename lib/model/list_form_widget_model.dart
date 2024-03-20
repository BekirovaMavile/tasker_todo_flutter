import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/list.dart';

class ListFormWidgetModel {
  var listName = '';
  Color? listColor;

  void saveList(BuildContext context) async {
    if (listName.isEmpty || listColor == null) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }
    final listBox = await Hive.openBox<Lists>('list_box');

    final list = Lists(
      name: listName,
      color: listColor!.value
    );

    await listBox.add(list);
    Navigator.of(context).pop();
    print(listName);
    print("Это в saveList: ${listColor!.value}");
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
    return false;
  }
}
