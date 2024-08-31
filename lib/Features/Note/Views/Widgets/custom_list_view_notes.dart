import 'package:flutter/material.dart';
import 'package:task_pad/Features/Note/Views/Widgets/custom_note_item.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';

class CustomListViewNotes extends StatelessWidget {
  const CustomListViewNotes({super.key, required this.notes});
  final List<NoteModel> notes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (context, index) => CustomNoteItem(
        note: notes[index],
      ),
    );
  }
}
