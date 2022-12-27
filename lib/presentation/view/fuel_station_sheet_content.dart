import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../business_logic/order_cubit/order_cubit.dart';
import '../../constants/strings.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_car_model.dart';
import '../styles/colors.dart';
import 'car_photo.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';
import '../widget/text_error.dart';
import 'fuel_station_sheet_content2.dart';
import 'fuel_station_sheet_content3.dart';

class FuelStationSheetContent extends StatelessWidget {
  FuelStationSheetContent({Key? key, required this.reverse, this.controller})
      : super(key: key);
  final bool reverse;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var globalCubit = GlobalCubit.get(context);
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);

        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: EdgeInsets.all(0.038 * screenWidth),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state is GetUserCarLoadingState
                      ? const ProgressIndicatorWidget()
                      : state is GetUserCarErrorState
                          ? const TextErrorWidget()
                          : SizedBox(
                              width: double.infinity,
                              height: 0.090 * screenHeight,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => CarPhotosView(
                                  userVehicle: orderCubit
                                      .userCarModel!.data!.userVehicles[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 0.05 * screenWidth),
                                itemCount: orderCubit
                                    .userCarModel!.data!.userVehicles.length,
                              ),
                            ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 0.127 * screenWidth,
                              height: 0.048 * screenHeight,
                              child: Image.asset(AppString.sMask2),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  text: 'Shell station',
                                  color: AppColor.lightBlack,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                                SizedBox(height: 0.003 * screenHeight),
                                DefaultText(
                                  text: 'Gas fuel',
                                  color: AppColor.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 0.076 * screenWidth,
                              height: 0.036 * screenHeight,
                              child: Image.asset(AppString.sStar),
                            ),
                            DefaultText(
                              text: '4.5 Stars',
                              color: AppColor.grey,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.018 * screenHeight),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (CacheHelper.getDataFromSharedPreference(
                                key: 'vehicleID') !=
                            null) {
                          globalCubit.changeSheetContentToSecondSheet2();
                        } else {
                          showToast("Please select a car", context,
                              toastDuration: 4);
                        }
                      },
                      child: DefaultContainer(
                        borderRadius: 30.sp,
                        color: AppColor.teal,
                        width: double.infinity,
                        height: 0.054 * screenHeight,
                        widget: DefaultText(
                          text: "Order Now",
                          color: AppColor.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppString.sActor,
                        ),
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
