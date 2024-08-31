import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_state.dart';
import 'package:task_pad/Features/ToDoTasks/Repository/to_do_task_repository_impl.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class ToDoTasksCubit extends Cubit<ToDoTasksState> {
  ToDoTasksCubit() : super(ToDoTaskInitialState());
  final ToDoTaskRepositoryImpl _toDoTaskRepositoryImpl =
      ToDoTaskRepositoryImpl();
  List<ToDoTaskModel> allTasks = [];
  List<ToDoTaskModel> toDoTasksUnCompleted = [];
  List<ToDoTaskModel> toDoTasksCompleted = [];
  List<ToDoTaskModel> toDoTasksSearch = [];
  String? dateTimeEntered;

  Future<List<ToDoTaskModel>> getAllTasks() async {
    emit(ToDoTaskLoadingState());
    allTasks.clear();
    allTasks = await _toDoTaskRepositoryImpl.getToDoTasks();
    if (allTasks.isEmpty) {
      toDoTasksCompleted.clear();
      toDoTasksUnCompleted.clear();
      emit(ToDoTaskNoDataState());
      return [];
    }
    _seperateTasks();
    emit(ToDoTaskSuccessState());
    return allTasks;
  }

  Future<int> insertToDoTask({required ToDoTaskModel toDoTask}) async {
    int id = await _toDoTaskRepositoryImpl.addToDoTask(task: toDoTask);
    await getAllTasks();

    return id;
  }

  Future<int> deleteToDoTask({required ToDoTaskModel toDoTask}) async {
    int id = await _toDoTaskRepositoryImpl.removeToDoTask(toDoTask);
    await getAllTasks();
    return id;
  }

  Future<int> updateToDoTask({required ToDoTaskModel toDoTask}) async {
    int id = await _toDoTaskRepositoryImpl.editToDoTask(toDoTask);
    await getAllTasks();
    return id;
  }

  Future<int> deleteAll() async {
    int id = await _toDoTaskRepositoryImpl.deleteAll();
    await getAllTasks();
    return id;
  }

  Future<List<ToDoTaskModel>> searchAboutTaskByTitle(
      {required String searchTitle}) async {
    // if value of search is empty, show all data
    if (searchTitle.isEmpty) {
      return await getAllTasks();
    }
    // if user enter any char search about it in database
    toDoTasksSearch =
        await _toDoTaskRepositoryImpl.searchTasksByTitle(searchTitle);
    // if no data for searching
    if (toDoTasksSearch.isEmpty) {
      emit(ToDoTaskNoSearchingState());
      return [];
    }
    emit(ToDoTaskSearchSuccessState());
    return toDoTasksSearch;
  }

//seperate task to compeleted and uncompeleted task
  void _seperateTasks() {
    // prevent duplicate
    toDoTasksCompleted.clear();
    toDoTasksUnCompleted.clear();
    // search about char
    for (ToDoTaskModel task in allTasks) {
      if (task.isCompeleted == 1) {
        toDoTasksCompleted.add(task);
      } else {
        toDoTasksUnCompleted.add(task);
      }
    }
  }
}
