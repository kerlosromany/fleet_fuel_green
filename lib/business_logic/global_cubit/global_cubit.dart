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

// make ocr logic

  int? cameraOcr = FlutterMobileVision.CAMERA_BACK;
  bool autoFocusOcr = true;
  bool torchOcr = false;
  bool multipleOcr = true;
  bool waitTapOcr = true;
  bool showTextOcr = true;
  Size? previewOcr;

  Future<void> mobileVisionInit() async {
    final previewSizes = await FlutterMobileVision.start();
    previewOcr = previewSizes[cameraOcr]!.first;
    //emit(MobileVisionInitState());
  }

  OcrText? oddoOCR;
  OcrText? literOCR;

  String? oddoOCRImagePath;
  String? literOCRImagePath;

  Future read(String fileName, OCRType ocrType) async {
    List<OcrText> texts = [];
    Size scanpreviewOcr = previewOcr ?? FlutterMobileVision.PREVIEW;
    if (ocrType == OCRType.oddo) {
      oddoOCRImagePath = await getFilePath(fileName);
    } else if (ocrType == OCRType.liter) {
      literOCRImagePath = await getFilePath(fileName);
    }
    try {
      texts = await FlutterMobileVision.read(
        flash: torchOcr,
        autoFocus: autoFocusOcr,
        multiple: multipleOcr,
        waitTap: waitTapOcr,
        forceCloseCameraOnTap: true,
        imagePath: ocrType == OCRType.oddo
            ? oddoOCRImagePath!
            : literOCRImagePath!, //'path/to/file.jpg'
        showText: showTextOcr,
        preview: previewOcr ?? FlutterMobileVision.PREVIEW,
        scanArea: Size(scanpreviewOcr.width - 20, scanpreviewOcr.height - 20),
        camera: cameraOcr ?? FlutterMobileVision.CAMERA_BACK,
        fps: 2.0,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }
    if (ocrType == OCRType.oddo) {
      oddoOCR = texts[0];
    } else if (ocrType == OCRType.liter) {
      literOCR = texts[0];
    }
    emit(MobileVisionTextOcrState());
  }

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName.jpg'; // 3

    return filePath;
  }
}

enum OCRType { oddo, liter }
