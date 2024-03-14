import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/models/list.dart';

class ListFormWidgetModel {
  var listName = '';
  Color? listColor; // Change type to Color

  void saveList(BuildContext context) async {
    if (listName.isEmpty || listColor == null) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ListsAdapter());
    }

    final box = await Hive.openBox<Lists>('list_box');
    final list = Lists(name: listName, color: listColor!);
    await box.add(list as Lists);
    Navigator.of(context).pop();
    print(listName);
    print(listColor);
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
    print("read");
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
