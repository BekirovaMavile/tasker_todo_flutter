import 'package:flutter/material.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import 'package:todo_app_flutter/ui/widgets/floating_action_button.dart';
import 'package:todo_app_flutter/ui/widgets/lists.dart';
import 'package:todo_app_flutter/ui_kit/_ui_kit.dart';
import '../../data/_data.dart';
import '../widgets/coloredDot.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Task> tasks = AppData.tasks;
  get category => AppData.categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: tasks[index].isCompleted,
                              shape: const CircleBorder(),
                              onChanged: (value) {
                                setState(() {
                                  tasks[index].isCompleted = value ?? false;
                                });
                              },
                              visualDensity: VisualDensity.adaptivePlatformDensity,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tasks[index].content, style: AppTextStyle.h2Style),
                                  ColoredDot(category: tasks[index].category),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 40.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: LightThemeColor.grey,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lists", style: AppTextStyle.h3Style,),
                    Lists(showCategoryDetails: _showCategoryDetails,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const FloatingButton(),
    );
  }


  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Today",
                style: AppTextStyle.h1Style,
              ),
            ],
          ),
          const Icon(
            Icons.more_horiz,
            color: LightThemeColor.blue,
            size: 34,
          ),
        ],
      ),
    );
  }

  void _showCategoryDetails(TaskCategory category) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: ToDoState().getCategoryColor(category),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              // Display category name and task count
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ToDoState().getCategoryName(category).toCapital,
                      style: AppTextStyle.h2Style.copyWith(color: Colors.black),
                    ),
                    Text(
                      "${ToDoState().getTaskCount(category)} tasks",
                      style: AppTextStyle.h5Style.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    if (tasks[index].category == category) {
                      return ListTile(
                        title: Text(tasks[index].content),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
