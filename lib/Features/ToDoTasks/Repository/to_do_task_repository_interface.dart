import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

abstract class ToDoTaskRepositoryInterface {
  Future<int> addToDoTask({required ToDoTaskModel task});
  Future<List<ToDoTaskModel>> getToDoTasks();
  Future<int> removeToDoTask(ToDoTaskModel task);
  Future<int> editToDoTask(ToDoTaskModel task);
  Future<List<ToDoTaskModel>> searchTasksByTitle(String searchByTitle);
  Future<void> deleteAll();
}
