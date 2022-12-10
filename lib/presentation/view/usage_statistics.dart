import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/payment_methods_cubit/payment_methods_state.dart';

import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class UsageStatistics extends StatelessWidget {
  const UsageStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PaymentMethodsCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(top: 0.3 * screenHeight),
          child: Center(
            child: DefaultContainer(
              borderRadius: 10.0,
              color: AppColor.white,
              width: 0.77 * screenWidth,
              height: 0.13 * screenHeight,
              widget: Padding(
                padding: EdgeInsets.all(0.0255 * screenWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.changeFuelUpDailyStates();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DefaultText(
                              text: 'Daily ',
                              color: AppColor.tealBackGround,
                              fontSize: 0.0255 * screenWidth,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DefaultContainer(
                          borderRadius: 10.0,
                          color: AppColor.grey2,
                          widget: const SizedBox(),
                          width: 1.0,
                          height: 0.024 * screenHeight,
                        ),
                        InkWell(
                          onTap: () {
                            cubit.changeFuelUpWeeklyStates();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DefaultText(
                              text: 'Weekly Fuelup',
                              color: AppColor.grey2,
                              fontSize: 0.0255 * screenWidth,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          text: '30 Liter',
                          color: AppColor.black,
                          fontSize: 0.0255 * screenWidth,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            DefaultText(
                              text: 'Monthly quota',
                              color: AppColor.grey3,
                              fontSize: 0.0255 * screenWidth,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: 0.0128 * screenWidth),
                            DefaultText(
                              text: '99 Liter',
                              color: AppColor.tealBackGround,
                              fontSize: 0.0383 * screenWidth,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: AppColor.grey8,
                      color: AppColor.green3,
                    ),
                    DefaultText(
                      text: 'Today : 01 - 01 - 2023',
                      color: AppColor.grey2,
                      fontSize: 0.0255 * screenWidth,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
