import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as date;
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Core/Utils/app_utils.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_elevated_icon.button.dart';
import 'package:task_pad/Features/ToDoTasks/model/to_do_task_model.dart';

class CustomDateAndTimeButtonSection extends StatefulWidget {
  const CustomDateAndTimeButtonSection({super.key, this.toDoTaskModel});
  final ToDoTaskModel? toDoTaskModel;

  @override
  State<CustomDateAndTimeButtonSection> createState() =>
      _CustomDateAndTimeButtonSectionState();
}

class _CustomDateAndTimeButtonSectionState
    extends State<CustomDateAndTimeButtonSection> {
  late ToDoTasksCubit cubitTaskDate;
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    cubitTaskDate = BlocProvider.of<ToDoTasksCubit>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.toDoTaskModel != null) {
      dateTime = AppUtils.stringToDateTime(
        context,
        cubitTaskDate.dateTimeEntered!,
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedIconButton(
      labe: cubitTaskDate.dateTimeEntered ?? AppUtils.formatDate(context),
      onPressed: () {
        date.DatePicker.showDateTimePicker(context,
            theme: const date.DatePickerTheme(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              headerColor: Color.fromARGB(255, 33, 33, 33),
              itemStyle: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              doneStyle: TextStyle(color: AppColors.blueColor, fontSize: 16),
              cancelStyle: TextStyle(color: AppColors.redColor, fontSize: 16),
            ),
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2100, 1, 1),
            onChanged: (date) {}, onConfirm: (date) {
          cubitTaskDate.dateTimeEntered =
              AppUtils.formatDate(context, dateTime: date);
          setState(() {});
        },
            currentTime: dateTime,
            locale: Localizations.localeOf(context).languageCode == 'en'
                ? date.LocaleType.en
                : date.LocaleType.ar);
      },
    );
  }
}
