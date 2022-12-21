import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';
import 'package:sizer/sizer.dart';

class MonthItem extends StatelessWidget {
  MonthItem({Key? key}) : super(key: key);
  int month = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    month = DateTime.now().month;
    print("Month $month");
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 0.24 * screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 1 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.120 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "January",
                    color: month == 1 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 2 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.130 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "Febraury",
                    color: month == 2 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 3 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.09 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "March",
                    color: month == 3 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 4 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.11 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "April",
                    color: month == 4 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 5 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.140 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "May",
                    color: month == 5 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 6 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.100 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "June",
                    color: month == 6 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 7 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.130 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "July",
                    color: month == 7 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 8 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.145 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "August",
                    color: month == 8 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: const SizedBox(),
                    color: month == 9 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.097 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "September",
                    color: month == 9 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    widget: const SizedBox(),
                    borderRadius: 8.sp,
                    color: month == 10 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.055 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "October",
                    color: month == 10 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: Container(),
                    color: month == 11 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.018 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "November",
                    color: month == 11 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultContainer(
                    borderRadius: 8.sp,
                    widget: Container(),
                    color: month == 12 ? AppColor.grey : AppColor.lightWhite,
                    width: 0.128 * screenWidth,
                    height: 0.11 * screenHeight,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                  DefaultText(
                    text: "December",
                    color: month == 12 ? AppColor.lightBlack : AppColor.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 0.0121 * screenHeight),
                ],
              ),
              SizedBox(width: 0.0383 * screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}
