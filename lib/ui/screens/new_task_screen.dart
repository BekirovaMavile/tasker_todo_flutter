import 'package:flutter/material.dart';
import 'package:todo_app_flutter/state/todo_state.dart';
import 'package:todo_app_flutter/ui/extension/app_extension.dart';
import 'package:todo_app_flutter/ui/widgets/coloredDot.dart';
import '../../data/_data.dart';
import '../../model/task_form_widget_model.dart';
import '../../ui_kit/_ui_kit.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments is int) {
        _model = TaskFormWidgetModel(listKey: arguments);
      } else {
        _model = TaskFormWidgetModel(listKey: 0);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
        model: _model!,
        child: const _TextFormWidgetBody()
    );
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaskTextWidget(),
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
          onPressed: () =>
              TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
          child: const Icon(Icons.done, size: 27, color: Colors.blue,),
        ),
      ),
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Text task',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}


// class NewTaskList extends StatefulWidget {
//   const NewTaskList({super.key});
//
//   @override
//   State<NewTaskList> createState() => _NewTaskListState();
// }
//
// class _NewTaskListState extends State<NewTaskList> {
//   bool wantToWrite = false;
//   List<Task> tasks = AppData.tasks;
//   TaskCategory category = TaskCategory.inbox;
//   bool isClockPressed = false;
//   bool isCalendarPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(color: Color(0xFF006CFF), fontSize: 18),
//                   ),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     "Done",
//                     style: TextStyle(
//                         color: Color(0xFF006CFF),
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       prefixIcon: Icon(
//                         Icons.circle_outlined,
//                         color: Colors.grey,
//                         size: 28,
//                       ),
//                       hintText: 'What do you want to do?',
//                     ),
//                     maxLines: null,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavigationBar(category),
//     );
//   }
//
//   Widget _bottomNavigationBar(TaskCategory category) {
//     String categoryName = ToDoState().getCategoryName(category);
//
//     return BottomAppBar(
//       color: Colors.white,
//       elevation: 0,
//       height: kBottomNavigationBarHeight,
//       child: Row(
//         children: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.insert_invitation,
//               color: isCalendarPressed ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () {
//               _showDatePicker();
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.schedule,
//               color: isClockPressed ? Colors.blue : Colors.grey,
//             ),
//             onPressed: () {
//               _showTimePicker();
//             },
//           ),
//           Spacer(),
//           Text(categoryName.toCapital, style: AppTextStyle.h4Style),
//           ColoredDot(category: tasks[3].category),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _showTimePicker() async {
//     TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (selectedTime != null) {
//       print('Selected time: ${selectedTime.format(context)}');
//       setState(() {
//         isClockPressed = true;
//       });
//     }
//   }
//
//   Future<void> _showDatePicker() async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//
//     if (selectedDate != null) {
//       print('Selected date: ${selectedDate.toLocal()}');
//       setState(() {
//         isCalendarPressed = true;
//       });
//     }
//   }
// }
