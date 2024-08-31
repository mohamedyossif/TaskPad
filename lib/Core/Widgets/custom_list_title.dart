import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
