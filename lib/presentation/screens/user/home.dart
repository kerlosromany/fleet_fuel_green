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
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';

import '../../../business_logic/take_photos_cubit/take_photos_cubit.dart';
import '../../../data/data_providers/local/cache_helper.dart';
import '../../widget/progress_indicator_widget.dart';
import '../../widget/toast.dart';

class HomePaage extends StatelessWidget {
  late int type;
  late String textController;
  HomePaage({Key? key, required this.type, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TakePhotosCubit, TakePhotosState>(
      listener: (context, state) {
        if (state is GetRecognizedTextState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var takePhotosCub = TakePhotosCubit.get(context);
        AspectRatio buildODOTargetPhoto() {
          return AspectRatio(
            aspectRatio: 8 / 1,
            child: Image.file(
              File(takePhotosCub.imageFileODO!.path),
              fit: BoxFit.cover,
            ),
          );
        }

        AspectRatio buildLitersTargetPhoto() {
          return AspectRatio(
            aspectRatio: 8 / 1,
            child: Image.file(
              File(takePhotosCub.imageFileLiters!.path),
              fit: BoxFit.cover,
            ),
          );
        }

        return Scaffold(
          body: FutureBuilder(
            future: takePhotosCub.initializationCamera(),
            builder: (context, snapshot) {
              if (type == 1) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return (CacheHelper.getDataFromSharedPreference(
                              key: "photo1Path") ==
                          null)
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
                                  width: 180,
                                  height: 90,
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
                          child: buildODOTargetPhoto(),
                        );
                } else {
                  return const ProgressIndicatorWidget();
                }
              } else {
                if (snapshot.connectionState == ConnectionState.done) {
                  return (CacheHelper.getDataFromSharedPreference(
                              key: "photo2Path") ==
                          null)
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
                                  width: 180,
                                  height: 90,
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
                              onTap: () => takePhotosCub.onTakeLitersPicture(),
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
                          child: buildLitersTargetPhoto(),
                        );
                } else {
                  return const ProgressIndicatorWidget();
                }
              }
            },
          ),
          floatingActionButton: type == 1
              ? ((CacheHelper.getDataFromSharedPreference(key: "photo1Path") !=
                      null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: FloatingActionButton(
                            heroTag: "button2",
                            backgroundColor: AppColor.teal,
                            child:
                                const Icon(Icons.close, color: AppColor.black),
                            onPressed: () {
                              takePhotosCub.removePhotoODOFromCache();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.check, color: AppColor.black),
                          backgroundColor: AppColor.teal,
                          heroTag: "button1",
                          onPressed: () async {
                            final controller = ScreenshotController();
                            final bytes = await controller.captureFromWidget(
                              Material(
                                child: buildODOTargetPhoto(),
                              ),
                            );
                            takePhotosCub.changeBytes(bytes);
                            takePhotosCub.saveImage(
                                bytes, context, textController);
                          },
                        ),
                      ],
                    )
                  : const SizedBox())
              : ((CacheHelper.getDataFromSharedPreference(key: "photo2Path") !=
                      null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: FloatingActionButton(
                            heroTag: "button2",
                            backgroundColor: AppColor.teal,
                            child:
                                const Icon(Icons.close, color: AppColor.black),
                            onPressed: ()  {
                              takePhotosCub.removePhotoLitersFromCache();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.check, color: AppColor.black),
                          backgroundColor: AppColor.teal,
                          heroTag: "button1",
                          onPressed: () async {
                            final controller = ScreenshotController();
                            final bytes = await controller.captureFromWidget(
                              Material(
                                child: buildLitersTargetPhoto(),
                              ),
                            );
                            takePhotosCub.changeBytes(bytes);
                            takePhotosCub.saveLitersImage(
                                bytes, context, textController);
                          },
                        ),
                      ],
                    )
                  : const SizedBox()),
        );
      },
    );
  }
}
