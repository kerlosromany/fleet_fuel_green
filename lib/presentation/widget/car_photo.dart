import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../data/data_providers/local/cache_helper.dart';
import '../styles/colors.dart';
import 'default_text.dart';
import 'package:sizer/sizer.dart';

class CarPhotoWidget extends StatelessWidget {
  const CarPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 0.308 * screenWidth,
      height: 0.08 * screenHeight,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Container(
            width: 0.309 * screenWidth,
            height: 0.02 * screenHeight,
            decoration: const BoxDecoration(
              color: AppColor.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultText(
                  text: 'Egypt',
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                  fontSize: 6.sp,
                ),
                DefaultText(
                  text: 'مصر',
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                  fontSize: 6.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 0.012 * screenHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: DefaultText(
              text: CacheHelper.getDataFromSharedPreference(key: "carNo"),
              fontWeight: FontWeight.bold,
              fontSize: 9.sp,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
