import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/business_logic/take_photos_cubit/take_photos_states.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/test.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';

import '../../../business_logic/take_photos_cubit/take_photos_cubit.dart';
import '../../widget/toast.dart';

class HomePaage extends StatelessWidget {
  const HomePaage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TakePhotosCubit(),
      child: BlocConsumer<TakePhotosCubit, TakePhotosState>(
        listener: (context, state) {
          if (state is GetRecognizedTextState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var takePhotosCub = TakePhotosCubit.get(context);
          AspectRatio buildTargetPhoto() {
            return AspectRatio(
              aspectRatio: 9 / 1,
              child: Image.file(
                File(takePhotosCub.imageFile!.path),
                fit: BoxFit.cover,
              ),
            );
          }

          return Scaffold(
            body: FutureBuilder(
              future: takePhotosCub.initializationCamera(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return takePhotosCub.imageFile == null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            CameraPreview(
                              takePhotosCub.controller,
                            ),
                            Container(
                              color: AppColor.black.withOpacity(0.8),
                              height: double.infinity,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.red,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => takePhotosCub.onTakePicture(),
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColor.white,
                                  child: Center(
                                      child: Icon(Icons.camera,
                                          size: 35, color: AppColor.teal)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: buildTargetPhoto(),
                        );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            floatingActionButton: takePhotosCub.imageFile != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        child: const Icon(Icons.check),
                        heroTag: "button1",
                        onPressed: () async {
                          final controller = ScreenshotController();
                          final bytes = await controller.captureFromWidget(
                            Material(
                              child: buildTargetPhoto(),
                            ),
                          );
                          takePhotosCub.changeBytes(bytes);
                          takePhotosCub.saveImage(bytes, context);
                          
                        },
                      ),
                      FloatingActionButton(
                        heroTag: "button2",
                        child: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
