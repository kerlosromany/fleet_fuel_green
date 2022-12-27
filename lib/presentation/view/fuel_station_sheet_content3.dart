import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';

import '../../constants/strings.dart';
import 'package:sizer/sizer.dart';
import '../styles/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widget/car_photo.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class FuelStationSheetContent3 extends StatelessWidget {
  const FuelStationSheetContent3(
      {Key? key, required this.reverse, this.controller})
      : super(key: key);
  final bool reverse;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);
        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // first row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 6.sp),
                            child: Image.asset(AppString.sMask2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                text: "Shell Station",
                                color: AppColor.lightBlack2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                children: [
                                  DefaultText(
                                    text: "Gas Fuel",
                                    color: AppColor.grey5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.sp),
                                    child: Image.asset(AppString.sStar),
                                  ),
                                  DefaultText(
                                    text: "4.5 stars",
                                    color: AppColor.grey5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        child: CarPhotoWidget(),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.024 * screenHeight),
                  state is GenerateCodeLoadingState
                      ? const ProgressIndicatorWidget()
                      : orderCubit.isGenerated
                          ? QrImage(
                              data: orderCubit.generatedCode,
                              version: QrVersions.auto,
                              size: 150.sp,
                              gapless: false,
                              errorStateBuilder: (cxt, err) {
                                return const Center(
                                  child: Text(
                                    "Uh oh! Something went wrong...",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            )
                          : DefaultText(
                              text: "Click Generated QR to get your qr code",
                              color: AppColor.red2,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                  SizedBox(height: 0.024 * screenHeight),
                  DefaultContainer(
                    borderRadius: 25.sp,
                    color: AppColor.teal,
                    width: double.infinity,
                    height: 0.054 * screenHeight,
                    widget: InkWell(
                      onTap: () {
                        orderCubit.generateCode();
                      },
                      child: DefaultText(
                        text: "Genrated QR",
                        color: AppColor.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppString.sActor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
