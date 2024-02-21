import 'package:flutter/material.dart';

class ListWidgetModel extends ChangeNotifier{
  var _list = <List>[];

  List<List> get list => _list.toList();
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