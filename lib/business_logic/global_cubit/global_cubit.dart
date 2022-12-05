import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/find_fuel_station_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/profile_settings.dart';

import '../../presentation/screens/shared/home_screen.dart';
import '../../presentation/screens/shared/orders_history.dart';
import '../../presentation/screens/shared/payment_method_screen.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  // password visibility Logic
  // bool isPassword = true;
  // void changePasswordVisibility() {
  //   isPassword = !isPassword;
  //   emit(ChangePasswordVisibiltyState());
  // }

  // bool isConfirmPassword = true;
  // void changeConfirmPasswordVisibility() {
  //   isConfirmPassword = !isConfirmPassword;
  //   emit(ChangeConfirmPasswordVisibiltyState());
  // }

  // change fuel station sheet content Logic
  void changeSheetContentToSecondSheet2() {
    emit(ChangeSheetContentToSecondSheet());
  }

  void changeSheetContentToThirdSheet3() {
    emit(ChangeSheetContentToThirdSheet());
  }

  // change bottom nav bar states
  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  List<Widget> screens = [
    FindFuelStationScren(),
    const PaymentMethodsScreen(),
    const OrdersHistoryScreen(),
    ProfileSettingsScreen(),
  ];
}
