import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../business_logic/order_cubit/order_cubit.dart';
import '../../constants/strings.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_car_model.dart';
import '../styles/colors.dart';
import '../widget/car_photo.dart';
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

        Widget _buildItemList(BuildContext context, int index) {
          return SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 100,
                  child: CarPhotoWidget(
                      carNumber: orderCubit.userCarModel!.data!
                          .userVehicles[index].carNumber as String),
                ),
              ],
            ),
          );
        }

        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state is GetUserCarLoadingState
                      ? const ProgressIndicatorWidget()
                      : state is GetUserCarErrorState
                          ? const TextErrorWidget()
                          : SizedBox(
                              height: 150,
                              child: ScrollSnapList(
                                onItemFocus: (index) {
                                  print(CacheHelper.getDataFromSharedPreference(
                                      key: 'imageID'));
                                  print("object");
                                  CacheHelper.saveDataSharedPreference(
                                      key: 'imageID',
                                      value: orderCubit.userCarModel!.data!
                                          .userVehicles[index].vehicleId);
                                  CacheHelper.saveDataSharedPreference(
                                      key: 'carNumber',
                                      value: orderCubit.userCarModel!.data!
                                          .userVehicles[index].carNumber);
                                },
                                itemBuilder: _buildItemList,
                                itemSize: 200,
                                dynamicItemSize: true,
                                onReachEnd: () {},
                                itemCount: orderCubit
                                    .userCarModel!.data!.userVehicles.length,
                              ),
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 40.0,
                            child: Image.asset(AppString.sMask2),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              DefaultText(
                                text: 'Shell station',
                                color: AppColor.lightBlack,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              DefaultText(
                                text: 'Gas fuel',
                                color: AppColor.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: Image.asset(AppString.sStar),
                          ),
                          const DefaultText(
                            text: '4.5 Stars',
                            color: AppColor.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (CacheHelper.getDataFromSharedPreference(
                                key: 'imageID') !=
                            null) {
                          globalCubit.changeSheetContentToSecondSheet2();
                        } else {
                          showToast("Please select a car", context);
                        }
                      },
                      child: const DefaultContainer(
                        borderRadius: 30.0,
                        color: AppColor.teal,
                        width: double.infinity,
                        height: 45.0,
                        widget: DefaultText(
                          text: "Order Now",
                          color: AppColor.white,
                          fontSize: 20.0,
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
