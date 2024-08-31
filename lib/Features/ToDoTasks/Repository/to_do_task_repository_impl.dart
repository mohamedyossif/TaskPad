import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/helper/dataBase/data_base_helper.dart';
import 'package:task_pad/Features/ToDoTasks/Repository/to_do_task_repository_interface.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

//Repository Pattern
class ToDoTaskRepositoryImpl extends ToDoTaskRepositoryInterface {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  ToDoTaskRepositoryImpl._private();
  static final _instance = ToDoTaskRepositoryImpl._private();
  factory ToDoTaskRepositoryImpl() {
    return _instance;
  }

  @override
  Future<int> addToDoTask({required ToDoTaskModel task}) async {
    final db = await dataBaseHelper.dataBase;

    return await db.insert(kNameTableToDoTask, task.toMap());
  }

  @override
  Future<List<ToDoTaskModel>> getToDoTasks() async {
    List<ToDoTaskModel> tasks = [];
    final db = await dataBaseHelper.dataBase;
    var data = await db.query(kNameTableToDoTask, orderBy: '$kDate ASC');
    //convert fron list of map to list of ToDoTaskModel
    for (Map<String, dynamic> task in data) {
      tasks.add(ToDoTaskModel.fromMap(task));
    }
    return tasks;
  }

  @override
  Future<int> removeToDoTask(ToDoTaskModel task) async {
    final db = await dataBaseHelper.dataBase;
    return await db
        .delete(kNameTableToDoTask, where: '$kId=?', whereArgs: [task.id]);
  }

  @override
  Future<int> editToDoTask(ToDoTaskModel task) async {
    final db = await dataBaseHelper.dataBase;
    return await db.update(kNameTableToDoTask, task.toMap(),
        where: '$kId=?', whereArgs: [task.id]);
  }

  @override
  Future<List<ToDoTaskModel>> searchTasksByTitle(String searchByTitle) async {
    List<ToDoTaskModel> tasks = [];
    final db = await dataBaseHelper.dataBase;
    var data = await db.query(kNameTableToDoTask, orderBy: '$kDate ASC');
    //convert from list of map to list of ToDoTaskModel
    for (var task in data) {
      // i do this beacuse i`m sure that title is String
      String title = task[kTitle] as String;
      // convert to loverCase to success searching
      if (title.toLowerCase().contains(searchByTitle.toLowerCase())) {
        tasks.add(ToDoTaskModel.fromMap(task));
      }
    }
    return tasks;
  }

  @override
  Future<int> deleteAll() async {
    final db = await dataBaseHelper.dataBase;
    return await db.rawDelete("DELETE FROM $kNameTableToDoTask");
  }
}
