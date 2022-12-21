import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/user_car_model.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/order_cubit/order_cubit.dart';
import '../../business_logic/order_cubit/order_states.dart';
import '../styles/colors.dart';

class CarPhotosView extends StatelessWidget {
  const CarPhotosView({
    Key? key,
    required this.userVehicle,
  }) : super(key: key);
  final UserVehicles userVehicle;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          OrderCubit.get(context).selectedCat(userVehicle);
          CacheHelper.saveDataSharedPreference(
              key: "carNo", value: userVehicle.carNumber);
          print(CacheHelper.getDataFromSharedPreference(key: "carNo"));
        },
        child: Container(
          width: OrderCubit.get(context)
                  .selectedVehicle
                  .any((element) => element == userVehicle)
              ? 0.33 * screenWidth
              : 0.308 * screenWidth,
          height: OrderCubit.get(context)
                  .selectedVehicle
                  .any((element) => element == userVehicle)
              ? 0.07 * screenHeight
              : 0.066 * screenHeight,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(
              color: Colors.black,
            ),
            boxShadow: OrderCubit.get(context)
                    .selectedVehicle
                    .any((element) => element == userVehicle)
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ]
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              Container(
                width: OrderCubit.get(context)
                        .selectedVehicle
                        .any((element) => element == userVehicle)
                    ? 0.331 * screenWidth
                    : 0.309 * screenWidth,
                height: OrderCubit.get(context)
                        .selectedVehicle
                        .any((element) => element == userVehicle)
                    ? 0.0217 * screenHeight
                    : 0.02 * screenHeight,
                decoration: const BoxDecoration(
                  color: AppColor.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultText(
                      text: 'Egypt',
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                      fontSize: 8.sp,
                    ),
                    DefaultText(
                      text: 'مصر',
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                      fontSize: 8.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.0121 * screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DefaultText(
                    text: userVehicle.carNumber!,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: AppColor.black,
                  ),
                  Container(
                    width: 0.0076 * screenWidth,
                    height: 0.0242 * screenHeight,
                    color: AppColor.black,
                  ),
                  DefaultText(
                    text: "م س",
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: AppColor.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
