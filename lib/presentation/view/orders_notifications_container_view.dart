import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class OrdersNotificationView extends StatelessWidget {
  final bool isNotification;
  const OrdersNotificationView({Key? key, required this.isNotification});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: DefaultContainer(
        color: AppColor.white,
        width: 0.86 * screenWidth,
        height: 0.18 * screenHeight,
        borderRadius: 8.sp,
        widget: Column(
          children: [
            // above half Info
            SizedBox(
              height: 0.0666 * screenHeight,
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  mainAxisAlignment: isNotification
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DefaultText(
                            text: "Vehicle number :",
                            color: AppColor.grey10,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w300),
                        DefaultText(
                            text: "1324 | م س",
                            color: AppColor.grey10,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w300),
                      ],
                    ),
                    if (!isNotification)
                      DefaultContainer(
                        color: AppColor.pendingColor.withOpacity(0.2),
                        width: 0.255 * screenWidth,
                        height: 0.06 * screenHeight,
                        widget: DefaultText(
                          text: "Pending",
                          color: AppColor.pendingColor,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        borderRadius: 10,
                      ),
                  ],
                ),
              ),
            ),
            Divider(
                color: Colors.grey,
                endIndent: 0.076 * screenWidth,
                indent: 0.076 * screenWidth),
            // below half Info
            SizedBox(
              height: 0.078 * screenHeight,
              child: ListTile(
                leading: DefaultContainer(
                  borderRadius: 10,
                  color: AppColor.pendingColor.withOpacity(0.2),
                  width: 0.178 * screenWidth,
                  height: 0.084 * screenHeight,
                  widget: const Icon(Icons.access_time,
                      color: AppColor.pendingColor),
                ),
                title: DefaultText(
                  color: AppColor.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  text: "Total Station - Nasr City",
                ),
                subtitle: Row(
                  children: [
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      text: "150L.E",
                    ),
                    SizedBox(width: 0.025 * screenWidth),
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w300,
                      text: "10 Liter",
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w300,
                      text: "29 Nov",
                    ),
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w300,
                      text: "12.30",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
