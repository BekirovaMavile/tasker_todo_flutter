import 'package:flutter/material.dart';
import 'package:todo_app_flutter/model/lists_widget_model.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';

class Lists extends StatefulWidget {
  Lists({Key? key, required this.showCategoryDetails});
  final void Function(TaskCategory) showCategoryDetails;

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  // List<TaskCategory> get categories => ToDoState().categories;
  final model = ListWidgetModel();

  @override
  Widget build(BuildContext context) {
    return ListWidgetModelProvider(
        model: model,
        child: _ListWidgetBody(
            showCategoryDetails: widget.showCategoryDetails)
    );
  }
}

class _ListWidgetBody extends StatelessWidget {
  const _ListWidgetBody({Key? key, required this.showCategoryDetails});
  final void Function(TaskCategory) showCategoryDetails;
  List<TaskCategory> get categories => ToDoState().categories;

  @override
  Widget build(BuildContext context) {
    final listCount = ListWidgetModelProvider.watch(context)?.model.list.length ?? 0;
    // return Column(
    //   children: categories.map((category) {
    //     Color colors = ToDoState().getCategoryColor(category);
    //     String categoryName = ToDoState().getCategoryName(category);

        return GestureDetector(
          // onTap: () => showCategoryDetails(category),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: 69,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              // color: colors,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listCount.toString())
                  // Text(categoryName.toCapital, style: AppTextStyle.h4Style),
                  // Text("${ToDoState().getTaskCount(category)} tasks", style: AppTextStyle.h5Style)
                ],
              ),
            ),
          ),
        );
      // }).toList(),
    // );
  }
}

