import 'package:flutter/material.dart';
import 'package:todo_app_flutter/model/task_widget_model.dart';

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
      _model = TasksWidgetModel(listKey: listKey);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
    );
  }
}

