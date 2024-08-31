import 'package:task_pad/Core/Utils/constants.dart';

class NoteModel {
  int? id;
  String subtitle, date;
  String title;

  NoteModel({
    required this.title,
    required this.subtitle,
    required this.date,
    this.id,
  });
  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        id: map[kId],
        title: map[kTitle],
        subtitle: map[kSubtitleNote],
        date: map[kDate],
      );
  toMap() {
    return {
      kId: id,
      kTitle: title,
      kSubtitleNote: subtitle,
      kDate: date,
    };
  }
}
