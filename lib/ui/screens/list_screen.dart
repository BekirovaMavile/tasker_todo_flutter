import 'package:flutter/material.dart';
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
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: LightThemeColor.grey,
                thickness: 2,
                indent: 45,
              ),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                          materialTapTargetSize: MaterialTapTargetSize
                                 .shrinkWrap,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(tasks[index].content, style: AppTextStyle.h2Style),
                            const Spacer(),
                            ColoredDot(category: tasks[index].category),
                          ],
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
                  Lists(),
                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: LightThemeColor.blue,),
        ),
      ),
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
