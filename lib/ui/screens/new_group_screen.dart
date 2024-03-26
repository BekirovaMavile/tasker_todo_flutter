import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_app_flutter/model/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
      model: _model,
      child: const _GroupFormWidgetBody(),
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
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
              _GroupNameWidget(),
              const SizedBox(height: 20),
              _GroupColorPickerWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
          backgroundColor: Colors.white,
          onPressed: () => model?.saveGroup(context),
          child: const Icon(Icons.done, size: 27, color: Colors.blue,),
        ),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'List name',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}

class _GroupColorPickerWidget extends StatefulWidget {
  const _GroupColorPickerWidget({Key? key}) : super(key: key);

  @override
  __GroupColorPickerWidgetState createState() => __GroupColorPickerWidgetState();
}

class __GroupColorPickerWidgetState extends State<_GroupColorPickerWidget> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
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
                          model?.groupColor = selectedColor;
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
