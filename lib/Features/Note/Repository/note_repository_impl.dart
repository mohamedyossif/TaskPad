import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/helper/dataBase/data_base_helper.dart';
import 'package:task_pad/Features/Note/Repository/note_repository_interface.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';

//Repository Pattern
class NoteRepositoryImpl extends NoteRepositoryInterface {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  NoteRepositoryImpl._private();
  static final _instance = NoteRepositoryImpl._private();
  factory NoteRepositoryImpl() {
    return _instance;
  }

  @override
  Future<int> addNote({required NoteModel note}) async {
    final db = await dataBaseHelper.dataBase;
    return await db.insert(kNameTableNotes, note.toMap());
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    List<NoteModel> notes = [];
    final db = await dataBaseHelper.dataBase;
    var data = await db.query(kNameTableNotes);
    //convert fron list of map to list of noteModel
    for (var note in data) {
      notes.add(NoteModel.fromMap(note));
    }

    return notes;
  }

  @override
  Future<int> removeNote(NoteModel note) async {
    final db = await dataBaseHelper.dataBase;
    return await db
        .delete(kNameTableNotes, where: '$kId=?', whereArgs: [note.id]);
  }

  @override
  Future<int> editNote(NoteModel note) async {
    final db = await dataBaseHelper.dataBase;
    return await db.update(kNameTableNotes, note.toMap(),
        where: '$kId=?', whereArgs: [note.id]);
  }

  @override
  Future<List<NoteModel>> searchNotesByTitle(String searchByTitle) async {
    List<NoteModel> notes = [];
    final db = await dataBaseHelper.dataBase;
    var data = await db.query(kNameTableNotes);
    //convert fron list of map to list of noteModel
    for (var note in data) {
      // i do this beacuse i`m sure that title is String
      String title = note['title'] as String;
      // convert to loverCase to success searching
      if (title.toLowerCase().contains(searchByTitle.toLowerCase())) {
        notes.add(NoteModel.fromMap(note));
      }
    }
    return notes;
  }

  @override
  Future<int> deleteAll() async {
    final db = await dataBaseHelper.dataBase;
    return await db.rawDelete("DELETE FROM $kNameTableNotes");
  }
}
