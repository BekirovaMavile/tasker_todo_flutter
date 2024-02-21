import 'package:flutter/material.dart';
import 'package:todo_app_flutter/model/list_form_widget_model.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({Key? key}) : super(key: key);

  @override
  State<ListFormWidget> createState() => _ListFormWidgetState();
}

class _ListFormWidgetState extends State<ListFormWidget> {
  final _model = ListFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return ListFormWidgetModelProvider(
        model: _model,
        child: const _ListFormWidgetBody(),
    );
  }
}

class _ListFormWidgetBody extends StatelessWidget {
  const _ListFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New list'),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _ListNameWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ListFormWidgetModelProvider.read(context)?.model.saveList(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _ListNameWidget extends StatelessWidget {
  const _ListNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ListFormWidgetModelProvider.read(context)?.model;
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'List name',
          ),
          onChanged: (value) => model?.listName = value,
          onEditingComplete: () => model?.saveList(context),
        ),
        SizedBox(height: 20),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'List color',
          ),
          onChanged: (value) => model?.listColor = value,
          onEditingComplete: () => model?.saveList(context),
        ),
      ],
    );
  }
}