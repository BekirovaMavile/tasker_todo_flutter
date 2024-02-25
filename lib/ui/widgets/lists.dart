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
  final model = ListWidgetModel();

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return ListWidgetModelProvider(
      model: model,
      child: _ListWidgetBody(
        showCategoryDetails: widget.showCategoryDetails,
        indexInList: index,
      ),
    );
  }
}

class _ListWidgetBody extends StatelessWidget {
  const _ListWidgetBody({Key? key, required this.showCategoryDetails, required this.indexInList});
  final void Function(TaskCategory) showCategoryDetails;
  final int indexInList;
  List<TaskCategory> get categories => ToDoState().categories;

  @override
  Widget build(BuildContext context) {
    final listCount = ListWidgetModelProvider.watch(context)?.model.list.length ?? 0;
    final lists = ListWidgetModelProvider.read(context)!.model.list[indexInList];
    return Column(
      children: categories.map((category) {
        // Color colors = ToDoState().getCategoryColor(category);
        // String categoryName = ToDoState().getCategoryName(category);
        // int taskCount = ListWidgetModelProvider.watch(context)?.model.getTaskCount(category) ?? 0;

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
                  Text(lists.name),
                  // Text(categoryName.toCapital, style: AppTextStyle.h4Style),
                  // Text("$taskCount tasks", style: AppTextStyle.h5Style)
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
