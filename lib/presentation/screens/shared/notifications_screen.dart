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
      drawer: const Drawer(),
      body: Stack(
        children: [
          DefaultContainer(
            color: AppColor.tealBackGround,
            width: double.infinity,
            height: 230,
            widget: Container(),
            borderRadius: 0.0,
          ),
          Positioned(
            top: 20,
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
