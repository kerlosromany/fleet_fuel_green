import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';

import '../styles/colors.dart';

class DefaultTextField extends StatelessWidget {
  final double height;
  String? img;
  IconData? iconData;
  final String hintTxt;
  final Color color;
  Color? fillColor;
  Color? styleColor;
  double? styleFontSize;
  String? fontFamily;
  final TextInputType textInputType;
  bool? isPassword = false;
  bool isSearch = false;
  final TextEditingController textEditingController;
  var validate;
  var onChange;

  VoidCallback? suffixPressed;
  VoidCallback? onTap;
  ValueChanged<String>? onFieldSubmitted;
  DefaultTextField({
    Key? key,
    required this.height,
    this.img,
    this.iconData,
    required this.hintTxt,
    required this.color,
    required this.textInputType,
    this.isPassword,
    this.fillColor,
    this.styleColor,
    this.styleFontSize,
    this.fontFamily,
    required this.isSearch,
    required this.textEditingController,
    required this.validate,
    this.suffixPressed,
    this.onTap,
    this.onFieldSubmitted,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPassword as bool,
      cursorColor: AppColor.teal,
      decoration: InputDecoration(
        prefixIcon: (img == null && isSearch == false)
            ? const SizedBox()
            : isSearch
                ? const Icon(Icons.search, color: AppColor.grey4)
                : Image.asset(img!),
        suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(iconData, color: AppColor.grey4)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 0, color: fillColor ?? AppColor.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 0, color: fillColor ?? AppColor.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 0, color: fillColor ?? AppColor.white),
        ),
        fillColor: fillColor ?? AppColor.white,
        filled: true,
        hintText: hintTxt,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: AppString.sActor,
          fontSize: 0.0408 * screenWidth,
          color: AppColor.grey4,
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: styleColor ?? AppColor.teal,
        fontSize: styleFontSize,
        fontFamily: fontFamily ?? AppString.sActor,
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      onTap: onTap,
      enabled: true,
      onChanged: onChange,
    );
  }
}
