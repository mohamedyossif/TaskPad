import 'package:flutter/material.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add'),
        ),
        body: Container(
          width: double.infinity,
          height: 500,
          child: const Row(
            children: [
              Icon(Icons.arrow_back),
              Text(
                'Add Note',
                textAlign: TextAlign.center,
                style: AppStyles.textStyledebold24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
