import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/data/models/list.dart';

class ListWidgetModel extends ChangeNotifier{
  var _list = <Lists>[];

  List<Lists> get list => _list.toList();
  ListWidgetModel(){
    _setup();
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