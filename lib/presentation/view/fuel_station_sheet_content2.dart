import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/order_cubit/order_states.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../data/data_providers/local/cache_helper.dart';
import '../styles/colors.dart';
import '../widget/car_photo.dart';
import 'car_photo.dart';

import 'fuel_station_sheet_content3.dart';

class FuelStationSheetContent2 extends StatefulWidget {
  const FuelStationSheetContent2(
      {Key? key, required this.reverse, this.controller})
      : super(key: key);
  final bool reverse;
  final ScrollController? controller;

  @override
  State<FuelStationSheetContent2> createState() =>
      _FuelStationSheetContent2State();
}

class _FuelStationSheetContent2State extends State<FuelStationSheetContent2> {
  TextEditingController odoController = TextEditingController();
  TextEditingController litersController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var cubit = GlobalCubit.get(context);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);
        if (state is NewOrderSuccessState) {
          cubit.changeSheetContentToThirdSheet3();
          print("changeSheetContentToThirdSheet3");
        }
        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // first row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.sp),
                              child: Image.asset(AppString.sMask2),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  text: "Shell Station",
                                  color: AppColor.lightBlack2,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                Row(
                                  children: [
                                    DefaultText(
                                      text: "Gas Fuel",
                                      color: AppColor.grey5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.sp),
                                      child: Image.asset(AppString.sStar),
                                    ),
                                    DefaultText(
                                      text: "4.5 stars",
                                      color: AppColor.grey5,
                                      fontSize: 12.sp,
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
                    // second row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultContainer(
                          color: AppColor.grey6,
                          width: 0.727 * screenWidth,
                          height: 0.078 * screenHeight,
                          borderRadius: 8.sp,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppString.sFuel),
                              Expanded(
                                flex: 4,
                                // odo
                                child: DefaultTextField(
                                  height: 0.0666 * screenHeight,
                                  isSearch: false,
                                  hintTxt: "",
                                  color: AppColor.grey6,
                                  isPassword: false,
                                  textInputType: TextInputType.number,
                                  textEditingController: odoController,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return "please enter the number of odo here";
                                    }
                                    return null;
                                  },
                                  fillColor: AppColor.grey6,
                                  styleColor: AppColor.red2,
                                  styleFontSize: 18.sp,
                                  fontFamily: AppString.sInriaSerif,
                                ),
                              ),
                              DefaultText(
                                text: "ODO",
                                color: AppColor.grey7,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppString.sActor,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            orderCubit.pickImage(
                                ImageSource.camera, context, 0);
                          },
                          child: orderCubit.imageFileOdo != null
                              ? DefaultContainer(
                                  widget: Image.file(
                                    File(orderCubit.imageFileOdo!.path),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: 10.sp,
                                  color: AppColor.white,
                                  height: 0.078 * screenHeight,
                                  width: 0.153 * screenWidth,
                                )
                              : DefaultContainer(
                                  borderRadius: 10.sp,
                                  color: AppColor.grey6,
                                  height: 0.078 * screenHeight,
                                  width: 0.153 * screenWidth,
                                  widget: const Image(
                                    image: AssetImage(AppString.sCamera),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.018 * screenHeight),
                    // third row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultContainer(
                          color: AppColor.grey6,
                          width: 0.727 * screenWidth,
                          height: 0.078 * screenHeight,
                          borderRadius: 8.sp,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppString.sCounter),
                              Expanded(
                                child: DefaultTextField(
                                  height: 0.0666 * screenHeight,
                                  isPassword: false,
                                  hintTxt: "",
                                  color: AppColor.grey6,
                                  textInputType: TextInputType.number,
                                  textEditingController: litersController,
                                  isSearch: false,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return "please enter the number of Liters here";
                                    }
                                    return null;
                                  },
                                  fillColor: AppColor.grey6,
                                  styleColor: AppColor.red2,
                                  styleFontSize: 18.sp,
                                  fontFamily: AppString.sInriaSerif,
                                ),
                              ),
                              DefaultText(
                                text: "Liter",
                                color: AppColor.grey7,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppString.sActor,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            orderCubit.pickImage(
                                ImageSource.camera, context, 1);
                          },
                          child: orderCubit.imageFileLiter != null
                              ? DefaultContainer(
                                  widget: Image.file(
                                    File(orderCubit.imageFileLiter!.path),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: 10.sp,
                                  color: AppColor.white,
                                  height: 0.078 * screenHeight,
                                  width: 0.153 * screenWidth,
                                )
                              : DefaultContainer(
                                  borderRadius: 10,
                                  color: AppColor.grey6,
                                  height: 0.078 * screenHeight,
                                  width: 0.153 * screenWidth,
                                  widget: const Image(
                                    image: AssetImage(AppString.sCamera),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.036 * screenHeight),
                    DefaultText(
                      text: "850 L.E.",
                      color: AppColor.green2,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppString.sInriaSerif,
                    ),
                    SizedBox(height: 0.036 * screenHeight),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate() &&
                            orderCubit.scannedTextOdo != "" &&
                            orderCubit.scannedTextLiter != "" &&
                            orderCubit.imageFileOdo != null &&
                            orderCubit.imageFileLiter != null) {
                          orderCubit.confirmOrder(
                            odoMeterInput: odoController.text,
                            odoMeterOcrText: orderCubit.scannedTextOdo,
                            literInput: litersController.text,
                            literOcrText: orderCubit.scannedTextLiter,
                            odoImage: File(orderCubit.imageFileOdo!.path),
                            litersImage: File(orderCubit.imageFileLiter!.path),
                            vehicleId: CacheHelper.getDataFromSharedPreference(
                                key: 'vehicleID'),
                            context: context,
                          );
                        } else if (orderCubit.scannedTextOdo == "" ||
                            orderCubit.scannedTextLiter == "") {
                          showToast("No number is picked", context);
                        } else {
                          showToast("Fill all Fields", context);
                        }
                        print(orderCubit.scannedTextOdo);
                        print(orderCubit.scannedTextLiter);
                      },
                      child: state is NewOrderLoadingState
                          ? const ProgressIndicatorWidget()
                          : DefaultContainer(
                              borderRadius: 25.sp,
                              color: AppColor.teal,
                              width: double.infinity,
                              height: 0.054 * screenHeight,
                              widget: DefaultText(
                                text: "Confirm Order",
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
          ),
        );
      },
    );
  }
}
