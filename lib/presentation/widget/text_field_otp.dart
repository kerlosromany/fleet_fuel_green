import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../business_logic/Login_cubit/login_cubit.dart';
import '../styles/colors.dart';

class TextFieldOtp extends StatelessWidget {
  //final double screenHeight;
  final bool first;
  bool? last;
  final LoginCubit cubit;
  TextFieldOtp({Key? key, required this.first, this.last, required this.cubit});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 0.06 * screenHeight,
      width: 0.127 * screenWidth,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          //controller: _codeController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              // cubit.changeCodeTextByAdding(value);
              // print(value.toString());
              // print(cubit.codeText);
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 0.061 * screenWidth, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
