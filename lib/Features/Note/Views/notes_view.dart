import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Features/Note/Views/Widgets/custom_note_item.dart';
import 'package:task_pad/Features/Note/Views/Widgets/header_notes.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          const HeaderNotes(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const CustomNoteItem(),
            ),
          )
        ],
      ),
    );
  }
}
