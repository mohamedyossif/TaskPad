import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pad/Core/Localization/classes/Localization_constant.dart';
import 'package:task_pad/Core/Utils/constants.dart';
import 'package:task_pad/Core/Widgets/custom_app_bar.dart';
import 'package:task_pad/Core/Widgets/custom_no_data.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_cubit.dart';
import 'package:task_pad/Features/ToDoTasks/Cubits/ToDoTasksCubit/to_do_task_state.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_compeleted_task_list.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_search_about_tasks.dart';
import 'package:task_pad/Features/ToDoTasks/Views/Widgets/custom_uncompeleted_task_list.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  TextEditingController searchController = TextEditingController();
  late ToDoTasksCubit cubitTasks;
  @override
  void initState() {
    cubitTasks = BlocProvider.of<ToDoTasksCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              indexBottomNav: 1,
              searchController: searchController,
              title: transation(context).to_do,
              hintTextField: transation(context).search_to_dos,
              onChanged: (value) async {
                await cubitTasks.searchAboutTaskByTitle(
                    searchTitle: searchController.text);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ToDoTasksCubit, ToDoTasksState>(
              builder: (context, state) {
                if (state is ToDoTaskSuccessState) {
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          _getUncompletedTasks(),
                          _getCompletedTasks(),
                        ],
                      ),
                    ),
                  );
                } else if (state is ToDoTaskSearchSuccessState) {
                  return CustomSearchAboutTasks(
                    tasks: cubitTasks.toDoTasksSearch,
                  );
                } else if (state is ToDoTaskNoDataState) {
                  return Expanded(
                      child: CustomNoData(
                    message: transation(context).to_do_empty,
                  ));
                } else if (state is ToDoTaskNoSearchingState) {
                  return Expanded(
                      child: CustomNoData(
                    message: transation(context).no_search_task,
                  ));
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

  Widget _getUncompletedTasks() {
    if (cubitTasks.toDoTasksUnCompleted.isNotEmpty) {
      return CustomUnCompeletedTaskList(
          tasksUncompleted: cubitTasks.toDoTasksUnCompleted);
    }
    return Container();
  }

  Widget _getCompletedTasks() {
    if (cubitTasks.toDoTasksCompleted.isNotEmpty) {
      return CustomCompeletedTaskList(
          tasksCompleted: cubitTasks.toDoTasksCompleted);
    }
    return Container();
  }
}
