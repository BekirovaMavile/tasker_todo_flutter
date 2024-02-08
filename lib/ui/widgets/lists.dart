import 'package:flutter/material.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';

class Lists extends StatelessWidget {
  const Lists({super.key, });
  List<TaskCategory> get categories => ToDoState().categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.map((category) {
        Color colors = _getCategoryColor(category);
        String categoryName = _getCategoryName(category);

        return Container(
          margin: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: 69,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: colors,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryName.toCapital, style: AppTextStyle.h4Style),
                Text("${_getTaskCount(category)} tasks", style: AppTextStyle.h5Style)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getCategoryColor(TaskCategory category) {
    switch (category) {
      case TaskCategory.inbox:
        return LightThemeColor.primaryLight;
      case TaskCategory.work:
        return LightThemeColor.green;
      case TaskCategory.shopping:
        return LightThemeColor.red;
      case TaskCategory.family:
        return LightThemeColor.yellow;
      case TaskCategory.personal:
        return LightThemeColor.purple;
      default:
        return Colors.grey;
    }
  }

  String _getCategoryName(TaskCategory category) {
    return category.toString().substring(category.toString().indexOf('.') + 1);
  }

  int _getTaskCount(TaskCategory category) {
    return 2;
  }
}
