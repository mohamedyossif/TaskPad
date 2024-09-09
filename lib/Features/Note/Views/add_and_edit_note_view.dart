import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Localization/classes/localization_constant.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/app_utils.dart';
import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/Widgets/custom_text_form_field.dart';
import 'package:task_pad/Core/Widgets/format_date.dart';
import 'package:task_pad/Features/Note/Cubits/NotesCubit/notes_cubit.dart';
import 'package:task_pad/Features/Note/model/note_model.dart';

class AddAndEditNoteView extends StatefulWidget {
  const AddAndEditNoteView({super.key, this.receivedNote});
  final NoteModel? receivedNote;
  @override
  State<AddAndEditNoteView> createState() => _AddAndEditNoteViewState();
}

class _AddAndEditNoteViewState extends State<AddAndEditNoteView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // user press as edit note or add note, null ==add note
    if (widget.receivedNote != null) {
      titleController.text = widget.receivedNote!.title;
      subtitleController.text = widget.receivedNote!.subtitle;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  // check if subtitle is empty ,don`t add note
                  if (formKey.currentState!.validate()) {
                    //save Data
                    NoteModel note = NoteModel.fromMap({
                      kTitle: titleController.text.isEmpty
                          ? 'Untitled '
                          : titleController.text,
                      kSubtitleNote: subtitleController.text,
                      kDate: AppUtils.formatDate(context),
                    });

                    await checkUpdateOrAddNote(note, context);
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
                icon: const Icon(Icons.check))
          ],
          leadingWidth: 30,
          title: Text(
            transation(context).notes,
            style: AppStyles.textStyleSemiBold25(context)
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: kPaddingScreen, left: kPaddingScreen, right: kPaddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomFormatDate(),
              CustomTextFormField(
                textEditingController: titleController,
                textStyleData: AppStyles.textStyleSemiBold25(context)
                    .copyWith(fontWeight: FontWeight.normal),
                maxLines: 1,
                minLines: 1,
                border: InputBorder.none,
                hint: transation(context).title,
                hintStyle: AppStyles.textStyleSemiBold20(context)
                    .copyWith(color: Colors.white.withOpacity(0.6)),
              ),
              Form(
                key: formKey,
                child: Expanded(
                  child: CustomTextFormField(
                    textEditingController: subtitleController,
                    textStyleData: AppStyles.textStyleRegulard16(context)
                        .copyWith(color: AppColors.whiteColor),
                    border: InputBorder.none,
                    hint: transation(context).note_subtitle,
                    isExpand: true,
                    maxLines: null,
                    minLines: null,
                    hintStyle: AppStyles.textStyleRegulard20(context),
                    validator: (value) => value!.isEmpty ? '' : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkUpdateOrAddNote(
      NoteModel note, BuildContext context) async {
    if (widget.receivedNote != null) {
      // database want id to update item which you press it to edit
      note.id = widget.receivedNote!.id;
      // user wants edit not add new note
      await BlocProvider.of<NotesCubit>(context)
          .updateNote(context, note: note);
    } else {
      // user wants add new note
      // id is automatically
      await BlocProvider.of<NotesCubit>(context).addNote(context, note: note);
    }
  }
}
