import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);

  void chnageScreen(context, {required int index}) {
    emit(index);
  }
}
