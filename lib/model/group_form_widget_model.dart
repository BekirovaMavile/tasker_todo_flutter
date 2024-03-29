import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_flutter/data/data_provider/box_manager.dart';
import '../data/models/group.dart';

class GroupFormWidgetModel {
  var groupName = '';
  Color? groupColor;

  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty || groupColor == null) return;

    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // final groupBox = await Hive.openBox<Group>('list_box');
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(
      name: groupName,
      color: groupColor,
    );
    await box.add(group);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();

    print(groupName);
    print("Это в saveList: ${groupColor}");
  }
}

class GroupFormWidgetModelProvider extends InheritedWidget {
  final GroupFormWidgetModel model;
  const GroupFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    child: child,
  );

  static GroupFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? read(BuildContext context) {
    print("read");
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
        ?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider oldWidget) {
    return false;
  }
}
