import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  String? imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF307777),
        title: Text("Image Cropper"),
      ),
      body: Container(
        child: imageFile == null
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: const Text(
                        "PICK FROM GALLERY",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : AspectRatio(
                aspectRatio: 2 / 1,
                child: Image.file(
                  File(imageFile!),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    imageFile = pickedFile!.path;
    setState(() {});
  }

  /// Crop Image
  // _cropImage(filePath) async {
  //   final croppedImage = await ImageCropper().cropImage(
  //     sourcePath: filePath,
  //     maxWidth: 1080,
  //     maxHeight: 1080,
  //   );
  //   if (croppedImage != null) {
  //     imageFile = croppedImage as File;
  //     setState(() {});
  //   }
  // }
}
