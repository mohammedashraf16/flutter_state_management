import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_state_management/controllers/task_event.dart';
import 'package:flutter_state_management/models/task_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      // ... spreed operator
      final model =
          TaskModel(id: Uuid().v4(), title: event.title, isCompleted: false);
      print(state.taskList);
      // first solution for create new list to add tasks
      emit(UpdateState([...state.taskList, model]));
      print(state.taskList);
      // second solution
      // TODO: emit(UpdateState(List.from(state.taskList)..add(model)));
    });

    on<DeleteTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.taskList
          .where(
            (task) => task.id != event.id,
          )
          .toList();
      emit(UpdateState(newList));
    });

    on<ToggleTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.taskList.map(
        (task) {
          return task.id == event.id
              ? task.copyWith(isCompleted: !task.isCompleted)
              : task;
        },
      ).toList();

      emit(UpdateState(newList));
    });
  }

  // addTask(String title) {}
  //
  // removeTask(String id) {}
  //
  // toggleTask(String id) {}
}
