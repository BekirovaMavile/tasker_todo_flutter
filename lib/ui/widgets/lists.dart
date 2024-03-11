import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/model/lists_widget_model.dart';
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _ListWidgetBody(
            indexInList: index, showCategoryDetails: showCategoryDetails);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
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
    // Color color = model?.getColorFromString(lists.color) ?? Colors.white;
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.white,
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deleteList(indexInList),
        ),
      ],
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 69,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.purple,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lists.name.toCapital, style: AppTextStyle.h4Style),
              Text("2 tasks", style: AppTextStyle.h5Style),
            ],
          ),
        ),
      ),
    );
  }
}
