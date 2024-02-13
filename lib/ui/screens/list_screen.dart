import 'package:flutter/material.dart';
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
                    const Lists(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingButton(),
      // floatingActionButton: SizedBox(
      //   height: 64,
      //   width: 64,
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     onPressed: () {},
      //     shape: const CircleBorder(),
      //     child: const Icon(Icons.add, color: LightThemeColor.blue,),
      //   ),
      // ),
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
}
