import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pad/Core/Utils/app_routes.dart';
import 'package:task_pad/Core/Utils/app_styles.dart';
import 'package:task_pad/Core/Utils/constants.dart';

class CustomNoteItem extends StatelessWidget {
  const CustomNoteItem({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRoutes.editNoteView);
      },
      child: Card(
        child: ListTile(
          title: const Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: 8),
            child: Text(
              'Flutter Course',
              style: AppStyles.textStyleSemiBold20,
            ),
          ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                'Font Awesome is the Internet\'s icon library and toolkit, used by millions of designers, developers, and content creators',
                style: AppStyles.textStyledefault16),
            const SizedBox(
              height: 6,
            ),
            Text(
              dateNow,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
