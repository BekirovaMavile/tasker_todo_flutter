import 'package:flutter/material.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key, required this.showCategoryDetails});
  final void Function(TaskCategory) showCategoryDetails;
  List<TaskCategory> get categories => ToDoState().categories;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.map((category) {
        Color colors = ToDoState().getCategoryColor(category);
        String categoryName = ToDoState().getCategoryName(category);

        return GestureDetector(
          onTap: () => showCategoryDetails(category),
          child: Container(
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
                  Text("${ToDoState().getTaskCount(category)} tasks", style: AppTextStyle.h5Style)
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
