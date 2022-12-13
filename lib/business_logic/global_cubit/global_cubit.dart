import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/find_fuel_station_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/profile_settings.dart';

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

  // ocr logic

  List<OcrText> list1 = [];
  startScanForODO() async {
    try {
      list1 =
          await FlutterMobileVision.read(waitTap: true, multiple: true, fps: 1);
      for (OcrText ocrText in list1) {
        print("Values is ${ocrText.value}");
      }
      print("first value is ${list1[0].value}");
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
      }
    } on Exception {
      list2.add(OcrText('Failed to recognize text.'));
      emit(LitersControllerErrorState());
    } catch (e) {
      print(e.toString());
      emit(LitersControllerErrorState());
    }
  }

  // user car data
  late UserCar userCarModel;
  getUserCarData() {
    emit(GetUserCarLoadingState());
    DioHelper.getData(
      url: epUSERCARS,
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      //print(value.data);
      userCarModel = UserCar.fromJson(value.data);
      print(userCarModel);
      print(userCarModel.message);
      print(userCarModel.data!.userVehicles);
      emit(GetUserCarSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserCarErrorState(error: error.toString()));
    });
  }

  // choose car photo logic
  int currentPhoto = 0;
  void changeCurrentPhoto(int photoIndex) {
    currentPhoto = photoIndex;
    emit(ChangeCarPhotoState());
  }

  // Make new order
  late NewOrderModel newOrderModel;
  confirmOrder({
    required String odoMeterInput,
    required String odoMeterOcrText,
    required String literInput,
    required String literOcrText,
    required File odoImage,
    required File litersImage,
    required String vehicleId,
    //required BuildContext context,
  }) {
    emit(NewOrderLoadingState());
    DioHelper.postData(
      url: epMAKENEWORDER,
      body: {
        "shipment_type_id": 1,
        "payment_type_id": 1,
        "fleetoLocation[longitude]": 30.95618,
        "fleetoLocation[latitude]": 29.96207,
        "order_details[odometer_input]": odoMeterInput,
        "order_details[odometer_ocr]": odoMeterOcrText,
        "order_details[liter_input]": literInput,
        "order_details[liter_ocr]": literOcrText,
        "order_details[vehicle_id]": vehicleId,
        "OcrImages[odometer_ocr]": odoImage,
        "OcrImages[liter_ocr]": litersImage,
      },
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      //print(value.data);
      newOrderModel = NewOrderModel.fromJson(value.data);
      //print(loginModel.data!.user!.token);

      emit(NewOrderSuccessState());
    }).catchError((error) {
      //showToast(AppString.sLoginError, context);
      emit(NewOrderErrorState(error: error.toString()));
    });
  }

  // pick ocr photo
  File? odoImage;
  File? litersImage;
  Future pickODOImage(context, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      odoImage = imageTemp;
      print("Succefully to pick image");
      emit(ChangePhotoState());
    } on PlatformException catch (e) {
      print("the error is ${e.toString()}");
      showToast("Failed to pick image", context);
    }
  }

  Future pickLitersImage(context, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      litersImage = imageTemp;
      emit(ChangePhotoState());
    } on PlatformException catch (e) {
      print("the error is ${e.toString()}");
      showToast("Failed to pick image", context);
    }
  }
}
