part of 'notes_cubit.dart';

abstract class NotesState {}

final class NoteInitialState extends NotesState {}

final class NoteSuccessState extends NotesState {}

final class NoteLoadingState extends NotesState {}

final class NoteNoDataState extends NotesState {}

final class NoteNoSearchingState extends NotesState {}

final class NoteSearchSuccessState extends NotesState {}
