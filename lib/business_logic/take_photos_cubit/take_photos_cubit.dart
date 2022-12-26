import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:magdsoft_flutter_structure/business_logic/take_photos_cubit/take_photos_states.dart';
import 'package:path_provider/path_provider.dart';

import '../../presentation/widget/toast.dart';

class TakePhotosCubit extends Cubit<TakePhotosState> {
  TakePhotosCubit() : super(TakePhotosInitialState());

  static TakePhotosCubit get(context) => BlocProvider.of(context);

  Uint8List? bytes;
  File? imageFile;
  late CameraController controller;
  File? file;

  Future saveImage(Uint8List bytes, BuildContext context) async {
    final appStorage = await getApplicationDocumentsDirectory();
    file = File('${appStorage.path}/image.jpeg');
    
    await file!.writeAsBytes(bytes);
    getRecognizedText(file!.path, context);
  }

  void changeBytes(bytess) {
    bytes = bytess;
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
      imageFile = img;
      emit(OnTakePicSuccessState());
    });
  }

  String scannedTextOdo = "";
  String scannedTextLiter = "";
  // Text Recognition using Google ML Kit
  void getRecognizedText(String imagePath, BuildContext context) async {
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
    print(scannedTextOdo);
    showToast(scannedTextOdo, context, toastDuration: 3);

    emit(GetRecognizedTextState());
  }
  
}