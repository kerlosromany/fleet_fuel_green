import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../business_logic/order_cubit/order_cubit.dart';
import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';
import '../widget/text_error.dart';
import 'fuel_station_sheet_content2.dart';
import 'fuel_station_sheet_content3.dart';

class FuelStationSheetContent extends StatelessWidget {
  const FuelStationSheetContent(
      {Key? key, required this.reverse, this.controller})
      : super(key: key);
  final bool reverse;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    var globalCubit = GlobalCubit.get(context);
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        print(CacheHelper.getDataFromSharedPreference(key: 'imageID'));
        var orderCubit = OrderCubit.get(context);
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
                              width: double.infinity,
                              height: 60.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => SizedBox(
                                  height: 70,
                                  child: InkWell(
                                    onTap: () {
                                      CacheHelper.saveDataSharedPreference(
                                          key: 'imageID',
                                          value: orderCubit.userCarModel.data!
                                              .userVehicles[index].vehicleId);
                                      orderCubit.changeCurrentPhoto(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow:
                                            orderCubit.currentPhoto == index
                                                ? [
                                                    const BoxShadow(
                                                      blurRadius: 5,
                                                      color: AppColor.grey6,
                                                      offset: Offset(0, 6),
                                                    ),
                                                  ]
                                                : [],
                                      ),
                                      child: const Image(
                                        image: AssetImage(AppString.sLic),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 5.0,
                                ),
                                itemCount: orderCubit
                                    .userCarModel.data!.userVehicles.length,
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
