import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';

import '../../router/app_routers_names.dart';
import '../../styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../../view/orders_notifications_container_view.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: AppColor.teal,
        title: const Text("Orders History"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRouterNames.rNotificationsScreen);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.sp),
              child: const ImageIcon(AssetImage(AppString.sNotify)),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
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
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
                OrdersNotificationView(isNotification: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
