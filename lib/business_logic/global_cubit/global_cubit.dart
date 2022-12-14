import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/find_fuel_station_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/profile_settings.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/end_points.dart';
import '../../data/data_providers/local/cache_helper.dart';
import '../../data/data_providers/remote/dio_helper.dart';
import '../../data/models/new_order_model.dart';
import '../../data/models/user_car_model.dart';
import '../../presentation/screens/shared/home_screen.dart';
import '../../presentation/screens/shared/orders_history.dart';
import '../../presentation/screens/shared/payment_method_screen.dart';
import '../../presentation/widget/toast.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

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

