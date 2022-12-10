import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/find_fuel_station_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/profile_settings.dart';

import '../../presentation/screens/shared/home_screen.dart';
import '../../presentation/screens/shared/orders_history.dart';
import '../../presentation/screens/shared/payment_method_screen.dart';

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

  // ocr logic
  TextEditingController odoController = TextEditingController();
  TextEditingController litersController = TextEditingController();
  void recieveController(controller1, controller2) {
    odoController = controller1;
    litersController = controller2;
    emit(ChangeControllersState());
  }

  int counter = 0;
  List<OcrText> list1 = [];
  startScanForODO() async {
    try {
      list1 =
          await FlutterMobileVision.read(waitTap: true, multiple: true, fps: 1);
      for (OcrText ocrText in list1) {
        print("Values is ${ocrText.value}");
        print("Value in controller is ${odoController.text}");
        if (ocrText.value == odoController.text) {
          
          emit(OdoControllerSuccessState());
        }
      }
    } on Exception {
      list1.add(OcrText('Failed to recognize text.'));
      emit(OdoControllerErrorState());
    } catch (e) {
      print(e.toString());
      emit(OdoControllerErrorState());
    }
  }

  List<OcrText> list2 = [];
  startScanForLiter() async {
    try {
      list2 =
          await FlutterMobileVision.read(waitTap: true, multiple: true, fps: 1);
      for (OcrText ocrText in list2) {
        print("Values is ${ocrText.value}");
        print("Value in controller is ${litersController.text}");
        if (ocrText.value == litersController.text) {
         
          emit(LitersControllerSuccessState());
        }
      }
    } on Exception {
      list2.add(OcrText('Failed to recognize text.'));
      emit(LitersControllerErrorState());
    } catch (e) {
      print(e.toString());
      emit(LitersControllerErrorState());
    }
  }
}
