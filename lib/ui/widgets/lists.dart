import 'package:flutter/material.dart';
import 'package:todo_app_flutter/model/lists_widget_model.dart';
import '../../data/_data.dart';

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
    return ListWidgetModelProvider(
        model: model,
        child: _ListWidget(
          showCategoryDetails: widget.showCategoryDetails,
        ));
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({super.key, required this.showCategoryDetails});

  final void Function(TaskCategory) showCategoryDetails;

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        ListWidgetModelProvider.watch(context)?.model.list.length ?? 0;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _ListWidgetBody(
            indexInList: index, showCategoryDetails: showCategoryDetails);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox.shrink();
      },
    );
  }
}

class _ListWidgetBody extends StatelessWidget {
  const _ListWidgetBody({
    Key? key,
    required this.showCategoryDetails,
    required this.indexInList,
  });

  final void Function(TaskCategory) showCategoryDetails;
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = ListWidgetModelProvider.read(context)!.model;
    final lists = model.list[indexInList];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lists.name),
      ],
    );
  }
}
