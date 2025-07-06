part of 'task_bloc.dart';

@immutable
sealed class TaskState extends Equatable{
  final List<TaskModel> taskList;

  const TaskState( this.taskList);
  @override
  List<Object?> get props => [taskList];
}

final class TaskInitial extends TaskState {
  TaskInitial():super([]);
}
class UpdateState extends TaskState{
  const UpdateState(super.model);
}
