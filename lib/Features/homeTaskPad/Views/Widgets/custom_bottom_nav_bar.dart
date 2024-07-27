import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_pad/Core/Utils/app_assets.dart';
import 'package:task_pad/Core/Utils/app_colors.dart';
import 'package:task_pad/Features/homeTaskPad/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:task_pad/Features/homeTaskPad/Data/bottom_nav_bar_item_model.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.backgroundBottomBar,
      items: [
        bottomNavItems(
            item: BottomNavBarItemModel(
                image: AppAssets.imagesNote,
                label: 'Notes',
                isActiveColor: currentIndex == 0)),
        bottomNavItems(
          item: BottomNavBarItemModel(
              image: AppAssets.imagesCheckList,
              label: 'To-Do',
              isActiveColor: currentIndex == 1),
        ),
      ],
      currentIndex: currentIndex,
      unselectedFontSize: 14,
      selectedFontSize: 14,
      selectedItemColor: AppColors.greenColor,
      onTap: (index) {
        BlocProvider.of<BottomNavBarCubit>(context).chnageScreen(index: index);
      },
    );
  }

//to generate item
  BottomNavigationBarItem bottomNavItems(
          {required BottomNavBarItemModel item}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(item.image,
              width: 30,
              colorFilter: ColorFilter.mode(
                item.isActiveColor ? const Color(0xff26CB02) : Colors.white,
                BlendMode.srcIn,
              )),
          label: item.label);
}
