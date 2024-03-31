import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/model/groups_widget_model.dart';
import 'package:todo_app_flutter/model/task_widget_model.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import 'package:todo_app_flutter/ui/screens/profile_screen.dart';
import 'package:todo_app_flutter/ui/widgets/floating_action_button.dart';
import 'package:todo_app_flutter/ui/widgets/group.dart';
import 'package:todo_app_flutter/ui_kit/_ui_kit.dart';
import '../../data/_data.dart';
import '../widgets/coloredDot.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: tasks.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.all(4.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Checkbox(
              //                 value: tasks.isEmpty,
              //                 shape: const CircleBorder(),
              //                 onChanged: (value) {
              //                   setState(() {
              //                     // tasks[index].isCompleted = value ?? false;
              //                   });
              //                 },
              //                 visualDensity:
              //                 VisualDensity.adaptivePlatformDensity,
              //                 materialTapTargetSize:
              //                 MaterialTapTargetSize.shrinkWrap,
              //               ),
              //               Expanded(
              //                 child: Row(
              //                   mainAxisAlignment:
              //                   MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text("tasks[index].content",
              //                         style: AppTextStyle.h2Style),
              //                     // ColoredDot(category: tasks[index].category),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Container(
              //             margin: const EdgeInsets.only(left: 40.0),
              //             decoration: const BoxDecoration(
              //               border: Border(
              //                 bottom: BorderSide(
              //                   color: LightThemeColor.grey,
              //                   width: 3,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: Text(
                    //     "Lists",
                    //     style: AppTextStyle.h3Style,
                    //   ),
                    // ),
                    Group(
                        // showCategoryDetails: _showCategoryDetails
                    )
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
                "Group",
                style: AppTextStyle.h1Style,
              ),
            ],
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
              color: LightThemeColor.blue,
              size: 34,
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Профиль'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

}
