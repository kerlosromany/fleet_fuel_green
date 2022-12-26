import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:magdsoft_flutter_structure/business_logic/take_photos_cubit/take_photos_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:path_provider/path_provider.dart';

import '../../presentation/widget/toast.dart';

class TakePhotosCubit extends Cubit<TakePhotosState> {
  TakePhotosCubit() : super(TakePhotosInitialState());

  static TakePhotosCubit get(context) => BlocProvider.of(context);

  late CameraController controller;

  Uint8List? bytesOdo;
  File? imageFileODO;
  File? fileODO;

  Future saveImage(Uint8List bytes, BuildContext context , String textController) async {
    final appStorage = await getApplicationDocumentsDirectory();
    fileODO = File('${appStorage.path}/image.jpeg');
    await fileODO!.writeAsBytes(bytes);
    getRecognizedText(fileODO!.path, context ,textController);

    emit(GetSavePhotoState());
  }

  void changeBytes(bytess) {
    bytesOdo = bytess;
    emit(ChangeBytesSuccessState());
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
  }

  void onTakePicture() async {
    await controller.takePicture().then((XFile xFile) {
      File? img = File(xFile.path);
      imageFileODO = img;
      CacheHelper.saveDataSharedPreference(
          key: "photo1Path", value: imageFileODO!.path);
    });
    emit(OnTakePicSuccessState());
  }

  String scannedTextOdo = "";

  // Text Recognition using Google ML Kit
  void getRecognizedText(String imagePath, BuildContext context , String textController) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedTextOdo = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedTextOdo = scannedTextOdo + line.text + "\n";
      }
    }
    bool isTrue = scannedTextOdo.contains(textController);
    print(scannedTextOdo);
    isTrue
        ? showToast("your number is $textController", context, toastDuration: 7)
        : showToast(
            "Can not find your number in the photo, Please try again.", context,
            toastDuration: 7);

    emit(GetRecognizedTextState());
  }

  /////////////////////////////////////////////////////////////////////////////
  Uint8List? bytesLiters;
  File? imageFileLiters;
  File? fileLiters;

  Future saveLitersImage(Uint8List bytes, BuildContext context , String textController) async {
    final appStorage = await getApplicationDocumentsDirectory();
    fileLiters = File('${appStorage.path}/image.jpeg');
    await fileLiters!.writeAsBytes(bytes);
    getRecognizedLitersText(fileLiters!.path, context , textController);

    emit(GetSavePhotoState());
  }

  void onTakeLitersPicture() async {
    await controller.takePicture().then((XFile xFile) {
      File? img = File(xFile.path);
      imageFileLiters = img;
      CacheHelper.saveDataSharedPreference(
          key: "photo2Path", value: imageFileLiters!.path);
    });
    emit(OnTakePicSuccessState());
  }

  String scannedTextLiter = "";
  // Text Recognition using Google ML Kit
  void getRecognizedLitersText(String imagePath, BuildContext context , String textController) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedTextLiter = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedTextLiter = scannedTextLiter + line.text + "\n";
      }
    }
    bool isTrue = scannedTextLiter.contains(textController);
    print(scannedTextLiter);
    isTrue
        ? showToast("your number is $textController", context, toastDuration: 7)
        : showToast(
            "Can not find your number in the photo, Please try again.", context,
            toastDuration: 7);

    emit(GetRecognizedTextState());
  }
}
