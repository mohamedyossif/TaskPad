import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_pad/Core/Utils/constants.dart';

class DataBaseHelper {
  static final DataBaseHelper _dataBaseHlper = DataBaseHelper._private();
  DataBaseHelper._private();
  factory DataBaseHelper() {
    return _dataBaseHlper;
  }
  static Database? _dataBase;

  Future<Database> get dataBase async {
    if (_dataBase != null) {
      return _dataBase!;
    }
    final String pathDataBase = join(await getDatabasesPath(), 'taskPad.db');
    _dataBase = await _initDataBase(pathDataBase);
    return _dataBase!;
  }

  // initial database
  Future<Database> _initDataBase(String pathDataBase) async {
    return await openDatabase(
      pathDataBase,
      version: 1,
      onCreate: (db, verison) async {
        await _createTable(db);
      },
    );
  }

  // create table
  Future<void> _createTable(Database db) async {
    await db.execute(
      'create table $kNameTableNotes ($kId integer primary key AUTOINCREMENT, $kTitle Text,$kSubtitleNote Text,$kDate Text )',
    );
    await db.execute(
        'create table $kNameTableToDoTask ($kId integer primary key AUTOINCREMENT, $kTitle Text,$kDate Text,$kTaskIsCompeleted integer )');
  }
}
