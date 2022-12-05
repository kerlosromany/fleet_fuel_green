import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class OrdersNotificationView extends StatelessWidget {
  final bool isNotification;
  const OrdersNotificationView({Key? key, required this.isNotification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultContainer(
        color: AppColor.white,
        width: 340,
        height: 150,
        borderRadius: 10,
        widget: Column(
          children: [
            // above half Info
            SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: isNotification
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text("Vehicle number :"),
                      Text("1324  م س"),
                    ],
                  ),
                  if (!isNotification)
                    DefaultContainer(
                      color: AppColor.pendingColor.withOpacity(0.2),
                      width: 100,
                      height: 50,
                      widget: const DefaultText(
                        text: "Pending",
                        color: AppColor.pendingColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      borderRadius: 10,
                    ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, endIndent: 30, indent: 30),
            // below half Info
            SizedBox(
              height: 65,
              child: ListTile(
                leading: DefaultContainer(
                  borderRadius: 10,
                  color: AppColor.pendingColor.withOpacity(0.2),
                  width: 70,
                  height: 70,
                  widget: const Icon(Icons.access_time,
                      color: AppColor.pendingColor),
                ),
                title: const DefaultText(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  text: "Total Station - Nasr City",
                ),
                subtitle: Row(
                  children: const [
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      text: "150L.E",
                    ),
                    SizedBox(width: 10),
                    DefaultText(
                      color: AppColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      text: "10 Liter",
                    ),
                  ],
                ),
                trailing: Column(
                  children: const [
                    Text("29 Nov"),
                    Text("12.30"),
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
