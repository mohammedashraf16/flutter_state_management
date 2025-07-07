sealed class TaskEvent{}
class AddTaskEvent extends TaskEvent{
  final String title;

  AddTaskEvent(this.title);
}
class DeleteTaskEvent extends TaskEvent{
  final String id;

  DeleteTaskEvent(this.id);
}
class ToggleTaskEvent extends TaskEvent{
  final String id;

  ToggleTaskEvent(this.id);
}