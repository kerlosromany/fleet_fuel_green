import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';

import '../../styles/colors.dart';
import '../../view/orders_notifications_container_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: AppColor.teal,
        title: const Text("Notification"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          DefaultContainer(
            color: AppColor.tealBackGround,
            width: double.infinity,
            height: 0.278 * screenHeight,
            widget: Container(),
            borderRadius: 0.0,
          ),
          Positioned(
            top: 0.02 * screenHeight,
            child: Image.asset(AppString.sBackGround),
          ),
          Center(
            child: ListView(
              children: const [
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
                OrdersNotificationView(isNotification: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
