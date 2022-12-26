import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
        print(
            "latitude is sent as => ${newOrderModel!.data!.order!.location!.latitude}");
        print(
            "longitude is sent as => ${newOrderModel!.data!.order!.location!.longitude}");
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

  String generatedCode = "";
  bool isGenerated = false;
  generateCode() {
    emit(GenerateCodeLoadingState());
    try {
      isGenerated = true;
      generatedCode = newOrderModel!.data!.paidApi as String;

      emit(GenerateCodeSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GenerateCodeErrorState());
    }
  }

// make ocr logic

  //make imagePicker and cropper
  File? imageFileOdo;
  File? imageFileLiter;
  Future pickImage(
      ImageSource imageSource, BuildContext context, int type) async {
    if (type == 0) {
      try {
        final image = await ImagePicker().pickImage(source: imageSource);
        if (image == null) {
          return;
        }
        File? img = File(image.path);
        //  img = await cropImage(imageFile: img, type: type, context: context);
        imageFileOdo = img;

        emit(SuccessPickImage());
      } on PlatformException catch (e) {
        print(e.toString());
        emit(ErrorPickImage());
      }
    } else {
      try {
        final image = await ImagePicker().pickImage(source: imageSource);
        if (image == null) {
          return;
        }
        File? img = File(image.path);
        // img = await cropImage(imageFile: img, type: type, context: context);
        imageFileLiter = img;

        emit(SuccessPickImage());
      } on PlatformException catch (e) {
        print(e.toString());
        emit(ErrorPickImage());
      }
    }
  }

  // make image cropper
  // Future<File?> cropImage(
  //     {required File imageFile,
  //     required int type,
  //     required BuildContext context}) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   getRecognizedText(croppedImage!.path, type, context);
  //   // if (croppedImage == null) {
  //   //   return null;
  //   // }
  //   return File(croppedImage.path);
  // }

  //////////////////////////////////////
  List<UserVehicles> selectedVehicle = [];

  void selectedCat(UserVehicles vehicle) {
    if (selectedVehicle.contains(vehicle)) {
      selectedVehicle.remove(vehicle);
      emit(RemoveSelectedVehicleIdState());
    } else {
      selectedVehicle = [];
      selectedVehicle.add(vehicle);
      emit(AddSelectedVehicleIdState());
    }
  }

  /////////////////////////////////////
  ///
  ///
  // ocr logic
  
}

enum OCRType { oddo, liter }
