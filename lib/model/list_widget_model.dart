import 'package:flutter/material.dart';

class ListWidgetModel {
  var listName = '';
  String listColor = '';
  void saveList(BuildContext context) {
    print(listName);
  }
}

class ListWidgetModelProvider extends InheritedWidget {
  final ListWidgetModel model;
  const ListWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
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

  @override
  bool updateShouldNotify(ListWidgetModelProvider oldWidget) {
    return true;
  }
}