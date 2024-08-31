import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Widgets/format_date.dart';
import 'package:task_pad/Features/Note/Cubits/NotesCubit/notes_cubit.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';

class CustomNoteItem extends StatelessWidget {
  final NoteModel note;
  const CustomNoteItem({super.key, required this.note});
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        GoRouter.of(context).push(AppRoutes.editNoteView, extra: note);
      },
      child: Dismissible(
        key: Key(note.id.toString()),
        background: Container(
          color: AppColors.redColor,
          alignment: Localizations.localeOf(context).languageCode == 'en'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: AppColors.whiteColor),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (dismiss) async {
          await cubit.deleteNote(context, note: note);
        },
        child: Card(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8),
              child: Text(
                note.title,
                style: AppStyles.textStyleSemiBold20(context),
              ),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                note.subtitle,
                style: AppStyles.textStyleRegulard20(context),
              ),
              const SizedBox(
                height: 6,
              ),
              const CustomFormatDate()
            ]),
          ),
        ),
      ),
    );
  }
}
