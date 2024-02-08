enum TaskCategory { inbox, work, shopping, family, personal }

class Task {
  final String content;
  final TaskCategory category;
  bool isCompleted;

  Task(this.content, this.category, {this.isCompleted = false});
}