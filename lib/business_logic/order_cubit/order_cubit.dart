import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:magdsoft_flutter_structure/constants/constants.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/end_points.dart';
import '../../data/data_providers/local/cache_helper.dart';
import '../../data/data_providers/remote/dio_helper.dart';
import '../../data/models/new_order_model.dart';
import '../../data/models/user_car_model.dart';
import '../../presentation/widget/toast.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);

  // user car data
  UserCar? userCarModel;
  getUserCarData() {
    emit(GetUserCarLoadingState());
    DioHelper.getData(
      url: epUSERCARS,
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      //print(value.data);
      userCarModel = UserCar.fromJson(value.data);
      //print(userCarModel.data.toString());
      print(userCarModel!.message);
      print(userCarModel!.data!.userVehicles.length);
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

  /////////////////////////////////////////////////////////////////////////////////////////////////

  // Make new order
  NewOrderModel? newOrderModel;
  Future<void> confirmOrder({
    required String odoMeterInput,
    required String odoMeterOcrText,
    required String literInput,
    required String literOcrText,
    required File odoImage,
    required File litersImage,
    required int vehicleId,
    required BuildContext context,
  }) async {
    emit(NewOrderLoadingState());
    String odoFile = odoImage.path.split('/').last;
    debugPrint("odoFile => $odoFile");
    String literFile = litersImage.path.split('/').last;
    debugPrint("literFile => $literFile");
    debugPrint("odoImage.path => ${odoImage.path}");
    debugPrint("litersImage.path => ${litersImage.path}");
    FormData formData = FormData.fromMap({
      'shipment_type_id': 1,
      'payment_type_id': 1,
      'fleetoLocation': {
        'longitude': AppConstants.longtude,
        'latitude': AppConstants.latitude,
      },
      'order_details': {
        'odometer_input': odoMeterInput,
        'odometer_ocr': odoMeterOcrText,
        'liter_input': literInput,
        'liter_ocr': literOcrText,
        'vehicle_id': vehicleId,
      },
      'OcrImages': {
        'odometer_ocr': await MultipartFile.fromFile(
          odoImage.path,
          filename: odoFile,
          //contentType: MediaType("image", "jpg"),
        ),
        'liter_ocr': await MultipartFile.fromFile(
          litersImage.path,
          filename: literFile,

          //contentType: MediaType("image", "jpg"),
        ),
      }
    });
    debugPrint(odoImage.path);
    debugPrint(litersImage.path);
    try {
      Response response = await DioHelper.postData(
        url: epMAKENEWORDER,
        isMultipart: true,
        token:
            "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
        body: formData,
      );
      debugPrint('//////////${response.requestOptions.data}');
      debugPrint('//////////${response.data}');
      if (response.statusCode == 200) {
        newOrderModel = NewOrderModel.fromJson(response.data);
        if (newOrderModel!.message == "validation error") {
          showToast(
              "Please try again , some errors happened , may be the size of photo is too large",
              context);
          emit(NewOrderErrorState(error: ""));
        }
        print("latitude is sent as => ${newOrderModel!.data!.order!.location!.latitude}");
        print("longitude is sent as => ${newOrderModel!.data!.order!.location!.longitude}");
        emit(NewOrderSuccessState());
      }
    } on DioError catch (e) {
      debugPrint('DioError 1 : ${e.message.toString()}');
      debugPrint('DioError 2: ${e.error.toString()}');
      showToast(
          "Please try again , some errors happened , maybe the size of photo is too large",
          context);
      emit(NewOrderErrorState(error: e.message));
    } catch (e) {
      debugPrint('DioError 3: ${e.toString()}');
      showToast("Please try again , some errors happened", context);
      emit(NewOrderErrorState(error: e.toString()));
    }
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
    emit(MobileVisionInitState());
  }

  OcrText? oddoOCR;
  OcrText? literOCR;
  String oddoText = "";
  String litersText = "";

  String? oddoOCRImagePath;
  String? literOCRImagePath;

  Future read(String fileName, OCRType ocrType, BuildContext context) async {
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
      oddoText = texts[0].value;
      showToast("the picked number is $oddoText", context, toastDuration: 7);
    } else if (ocrType == OCRType.liter) {
      literOCR = texts[0];
      litersText = texts[0].value;
      showToast("the picked number is $litersText", context, toastDuration: 7);
    }
    print(texts[0].value);
    emit(MobileVisionTextOcrState());
  }

  File? odoImageFile;
  File? litersImageFile;
  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName.png'; // 3
    debugPrint("file path = $filePath");

    // if (fileName == "oddoOcr") {
    //   odoImageFile = File(filePath);
    // } else {
    //   litersImageFile = File(filePath);
    // }

    return filePath;
  }
}

enum OCRType { oddo, liter }
