import '../data/_data.dart';

class ToDoState {
  ToDoState._();

  static final _instance = ToDoState._();

  factory ToDoState() => _instance;

  //Переменные
  List<TaskCategory> categories = AppData.categories;
}