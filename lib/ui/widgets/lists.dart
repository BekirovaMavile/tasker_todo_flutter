import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/model/lists_widget_model.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';


class Lists extends StatefulWidget {
  Lists({
    Key? key,
    // required this.showCategoryDetails
  });

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
        ));
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    super.key,
    // required this.showCategoryDetails
  });

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
            indexInList: index,
            // showCategoryDetails: showCategoryDetails
        );
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
    required this.indexInList,
  });
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = ListWidgetModelProvider.read(context)!.model;
    final lists = model.list[indexInList];
    final Color colors = Color(lists.color!);

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
      child: GestureDetector(
        onTap: () => model.showTasks(context, indexInList),
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: 69,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: colors,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lists.name.toCapital, style: AppTextStyle.h4Style),
                FutureBuilder<int>(
                  future: model.getTaskCount(indexInList),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Text("${snapshot.data} tasks", style: AppTextStyle.h5Style);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

