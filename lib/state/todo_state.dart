import '../data/_data.dart';

class ToDoState {
  ToDoState._();

  static final _instance = ToDoState._();

  factory ToDoState() => _instance;

  //Переменные
  List<TaskCategory> categories = AppData.categories;

  String getCategoryName(TaskCategory category) {
    return category.toString().substring(category.toString().indexOf('.') + 1);
  }

  int getTaskCount(TaskCategory category) {
    int count = 0;
    for (Task task in AppData.tasks) {
      if (task.category == category) {
        count++;
      }
    }
    return count;
  }
}