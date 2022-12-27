import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/payment_methods_cubit/payment_methods_cubit.dart';

import '../../../constants/strings.dart';
import '../../router/app_routers_names.dart';
import '../../styles/colors.dart';
import '../../view/balance_item.dart';
import '../../view/current_balance_item.dart';
import '../../view/month_item.dart';
import '../../view/usage_statistics.dart';
import 'package:sizer/sizer.dart';
import '../../widget/default_text.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<PaymentMethodsCubit>(
      create: (context) => PaymentMethodsCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: AppColor.teal,
          title: const Text("Payment methods"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRouterNames.rNotificationsScreen);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: const ImageIcon(AssetImage(AppString.sNotify)),
              ),
            ),
          ],
          centerTitle: true,
        ),
        drawer: const Drawer(),
        body: Stack(
          children: [
            Container(
              color: AppColor.tealBackGround,
              width: double.infinity,
              height: 0.35 * screenHeight,
            ),
            Padding(
              padding: EdgeInsets.only(right: 0.51 * screenWidth),
              child: Align(
                alignment: Alignment.topRight,
                child: ImageIcon(
                  const AssetImage(AppString.sBackGround),
                  size: 0.29 * screenHeight,
                  color: AppColor.teal,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 0.2 * screenWidth,
                    child: Image.asset(AppString.sProfileImage),
                  ),
                  DefaultText(
                    text: 'أحمد السيد جلال',
                    color: AppColor.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  DefaultText(
                    text: 'مدرسة فيوتشر',
                    color: AppColor.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            const CurrentBalanceItem(),
            const BalanceItem(),
            Padding(
              padding: EdgeInsets.only(top: 0.12 * screenHeight),
              child: Center(
                child: DefaultText(
                  text: 'Usage Statistics',
                  color: AppColor.tealBackGround,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const UsageStatistics(),
            MonthItem(),
          ],
        ),
      ),
    );
  }
}
