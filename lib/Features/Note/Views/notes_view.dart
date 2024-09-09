import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';
import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/Widgets/custom_app_bar.dart';
import 'package:task_pad/Core/Widgets/custom_no_data.dart';
import 'package:task_pad/Features/Note/Cubits/NotesCubit/notes_cubit.dart';
import 'package:task_pad/Features/Note/Views/Widgets/custom_list_view_notes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingScreen),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomAppBar(
              indexBottomNav: 0,
              onChanged: (value) async {
                await notesCubit.searchAboutNotesByTitle(context,
                    searchTitle: value);
              },
              searchController: searchController,
              title: transation(context).notes,
              hintTextField: transation(context).search_notes,
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state is NoteSuccessState) {
                  return Expanded(
                      child: CustomListViewNotes(notes: notesCubit.notes));
                } else if (state is NoteSearchSuccessState) {
                  return Expanded(
                    child: CustomListViewNotes(notes: notesCubit.notesSearch),
                  );
                } else if (state is NoteNoDataState) {
                  return Expanded(
                      child: CustomNoData(
                          message: transation(context).note_empty));
                } else if (state is NoteNoSearchingState) {
                  return Expanded(
                      child: CustomNoData(
                          message: transation(context).no_search_note));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
