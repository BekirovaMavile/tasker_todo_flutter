import 'package:flutter/material.dart';
import 'package:todo_app_flutter/model/lists_widget_model.dart';
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
                              visualDensity:
                              VisualDensity.adaptivePlatformDensity,
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tasks[index].content,
                                      style: AppTextStyle.h2Style),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Lists",
                        style: AppTextStyle.h3Style,
                      ),
                    ),
                    Lists(showCategoryDetails: _showCategoryDetails)
                    // _lists(context),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: ToDoState().getCategoryColor(category),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 60, top: 16, bottom: 10, right: 26),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ToDoState()
                              .getCategoryName(category)
                              .toCapital,
                          style: AppTextStyle.h1Style
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "${ToDoState().getTaskCount(category)} tasks",
                          style: AppTextStyle.h3Style
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.create,
                        size: 27,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      if (tasks[index].category == category) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: tasks[index].isCompletedBottom,
                                  shape: const CircleBorder(),
                                  onChanged: (value) {
                                    setState(() {
                                      tasks[index].isCompletedBottom =
                                          value ?? false;
                                    });
                                  },
                                  visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                                  materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text(tasks[index].content,
                                    style: AppTextStyle.h3Style
                                        .copyWith(color: Colors.black)),
                              ],
                            ),
                            const Divider(
                              color: Colors.black26,
                            )
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _lists(BuildContext context) {
  //   final groupsCount = ListWidgetModelProvider.watch(context)?.model.list.length ?? 0;
  //   print("groupsCount: $groupsCount");
  //
  //   return ListView.separated(
  //
  //     shrinkWrap: true,
  //     itemCount: groupsCount,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         tileColor: Colors.red,
  //         title: Text("name"),
  //         trailing: const Icon(Icons.chevron_right),
  //         onTap: () {},
  //       );
  //
  //       // return _ListWidgetBody(indexInList: index, showCategoryDetails: _showCategoryDetails);
  //     },
  //     separatorBuilder: (BuildContext context, int index) {
  //       return const Divider(height: 5);
  //     },
  //   );
  // }
}
