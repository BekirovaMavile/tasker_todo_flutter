import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  const _ListFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ListFormWidgetModelProvider.read(context)?.model;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New list'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ListNameWidget(),
              const SizedBox(height: 20),
              _ListColorPickerWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.saveList(context),
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
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'List name',
      ),
      onChanged: (value) => model?.listName = value,
      onEditingComplete: () => model?.saveList(context),
    );
  }
}

class _ListColorPickerWidget extends StatefulWidget {
  const _ListColorPickerWidget({Key? key}) : super(key: key);

  @override
  __ListColorPickerWidgetState createState() => __ListColorPickerWidgetState();
}

class __ListColorPickerWidgetState extends State<_ListColorPickerWidget> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.white; // Set initial color
  }

  @override
  Widget build(BuildContext context) {
    final model = ListFormWidgetModelProvider.read(context)?.model;
    return Column(
      children: [
        Text('Selected Color:'),
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Pick a color'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: selectedColor,
                        onColorChanged: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          model?.listColor = selectedColor; // Set selected color to model
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedColor,
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
