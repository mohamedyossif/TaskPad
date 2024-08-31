import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Features/Note/Repository/note_repository_impl.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NoteInitialState());
  final NoteRepositoryImpl _noteRepositoryImpl = NoteRepositoryImpl();
  List<NoteModel> notes = [];
  List<NoteModel> notesSearch = [];

  Future<List<NoteModel>> getAllNotes() async {
    emit(NoteLoadingState());
    notes = await _noteRepositoryImpl.getNotes();
    if (notes.isEmpty) {
      emit(NoteNoDataState());
      return [];
    } else {
      emit(NoteSuccessState());
      return notes;
    }
  }

  Future<int> addNote(context, {required NoteModel note}) async {
    int id = await _noteRepositoryImpl.addNote(note: note);
    await getAllNotes();

    return id;
  }

  Future<int> deleteNote(context, {required NoteModel note}) async {
    int id = await _noteRepositoryImpl.removeNote(note);
    await getAllNotes();

    return id;
  }

  Future<int> updateNote(context, {required NoteModel note}) async {
    int id = await _noteRepositoryImpl.editNote(note);
    await getAllNotes();
    return id;
  }

  Future<int> deleteAll() async {
    int id = await _noteRepositoryImpl.deleteAll();
    await getAllNotes();
    return id;
  }

  Future<List<NoteModel>> searchAboutNotesByTitle(
    context, {
    required String searchTitle,
  }) async {
    // if value of search is empty show all data
    if (searchTitle.isEmpty) {
      return await getAllNotes();
    }
    // if user enter any char search about it in database
    notesSearch = await _noteRepositoryImpl.searchNotesByTitle(searchTitle);
    if (notesSearch.isEmpty) {
      emit(NoteNoSearchingState());
      return [];
    }
    emit(NoteSearchSuccessState());
    return notesSearch;
  }
}
