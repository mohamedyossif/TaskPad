import 'package:task_pad/Features/Note/model/note_model.dart';

abstract class NoteRepositoryInterface {
  Future<int> addNote({required NoteModel note});
  Future<List<NoteModel>> getNotes();
  Future<int> removeNote(NoteModel note);
  Future<int> editNote(NoteModel note);
  Future<List<NoteModel>> searchNotesByTitle(String searchByTitle);
  Future<void> deleteAll();
}
