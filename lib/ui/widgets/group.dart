import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/model/groups_widget_model.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';

class Group extends StatefulWidget {
  Group({
    Key? key,
  });

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  final model = GroupWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(
        model: model,
        child: _GroupWidget(
        ),
    );
  }
}

class _GroupWidget extends StatelessWidget {
  const _GroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupWidgetModelProvider.watch(context)?.model.group.length ?? 0;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _GroupWidgetBody(
            indexInList: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
    );
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({
    Key? key,
    required this.indexInList,
  });
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.read(context)!.model;
    final groups = model.group[indexInList];
    final Color? color = groups.color;
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.white,
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deleteGroup(indexInList),
        ),
      ],
      child: GestureDetector(
        onTap: () => model.showTasks(context, indexInList),
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 69,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groups.name.toCapital, style: AppTextStyle.h4Style),
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

