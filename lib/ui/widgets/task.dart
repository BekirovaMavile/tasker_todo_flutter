import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/model/task_widget_model.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final listKey = ModalRoute
          .of(context)!
          .settings
          .arguments as int;
      _model = TasksWidgetModel(groupKey: listKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
        model: _model!,
        child: const TasksWidgetBody()
    );
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Tasks';
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toCapital),
      ),
      body: _TaskListWidget(),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
          backgroundColor: Colors.white,
          onPressed: () => model?.showForm(context),
          child: const Icon(Icons.add, size: 27, color: Colors.blue,),
        ),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(indexInList: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone ? Icons.done : null;
    final style = task.isDone
        ? const TextStyle(
      decoration: TextDecoration.lineThrough,
    )
        : null;

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.white,
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deleteTask(indexInList),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.text,
            style: style,
          ),
          trailing: Icon(icon),
          onTap: () => model.doneToggle(indexInList),
        ),
      ),
    );
  }
}
