import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
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
import 'fuel_station_sheet_content3.dart';

class FuelStationSheetContent2 extends StatefulWidget {
  const FuelStationSheetContent2({Key? key}) : super(key: key);

  @override
  State<FuelStationSheetContent2> createState() =>
      _FuelStationSheetContent2State();
}

class _FuelStationSheetContent2State extends State<FuelStationSheetContent2> {
  TextEditingController odoController = TextEditingController();
  TextEditingController litersController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    OrderCubit.get(context).mobileVisionInit();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);

        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(AppString.sMask2),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const DefaultText(
                                  text: "Shell Station",
                                  color: AppColor.lightBlack2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                Row(
                                  children: [
                                    const DefaultText(
                                      text: "Gas Fuel",
                                      color: AppColor.grey5,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.asset(AppString.sStar),
                                    ),
                                    const DefaultText(
                                      text: "4.5 stars",
                                      color: AppColor.grey5,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          child: Image(
                            image: AssetImage(AppString.sLic),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // second row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultContainer(
                          color: AppColor.grey6,
                          width: 285,
                          height: 65,
                          borderRadius: 10,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppString.sFuel),
                              Expanded(
                                flex: 4,
                                // odo
                                child: DefaultTextField(
                                  height: 55,
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
                                  styleFontSize: 26,
                                  fontFamily: AppString.sInriaSerif,
                                ),
                              ),
                              const DefaultText(
                                text: "ODO",
                                color: AppColor.grey7,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppString.sActor,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            orderCubit.read('oddoOcr', OCRType.oddo);
                          },
                          child: orderCubit.oddoOCRImagePath != null
                              ? DefaultContainer(
                                  widget: Image.file(
                                      File(orderCubit.oddoOCRImagePath!),
                                      fit: BoxFit.cover),
                                  borderRadius: 10,
                                  color: AppColor.white,
                                  height: 65,
                                  width: 60,
                                )
                              : const DefaultContainer(
                                  borderRadius: 10,
                                  color: AppColor.grey6,
                                  height: 65,
                                  width: 60,
                                  widget: Image(
                                    image: AssetImage(AppString.sCamera),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // third row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DefaultContainer(
                          color: AppColor.grey6,
                          width: 285,
                          height: 65,
                          borderRadius: 10,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(AppString.sCounter),
                              Expanded(
                                child: DefaultTextField(
                                  height: 50,
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
                                  styleFontSize: 30,
                                  fontFamily: AppString.sInriaSerif,
                                ),
                              ),
                              const DefaultText(
                                text: "Liter",
                                color: AppColor.grey7,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppString.sActor,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            orderCubit.read('literOcr', OCRType.liter);
                          },
                          child: orderCubit.literOCRImagePath != null
                              ? DefaultContainer(
                                  widget: Image.file(
                                      File(orderCubit.literOCRImagePath!),
                                      fit: BoxFit.cover),
                                  borderRadius: 10,
                                  color: AppColor.white,
                                  height: 65,
                                  width: 60,
                                )
                              : const DefaultContainer(
                                  borderRadius: 10,
                                  color: AppColor.grey6,
                                  height: 65,
                                  width: 60,
                                  widget: Image(
                                    image: AssetImage(AppString.sCamera),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const DefaultText(
                      text: "850 L.E.",
                      color: AppColor.green2,
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppString.sInriaSerif,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate() &&
                            orderCubit.oddoText != "" &&
                            orderCubit.litersText != "" &&
                            orderCubit.odoImageFile != null &&
                            orderCubit.litersImageFile != null) {
                          orderCubit
                              .confirmOrder(
                            odoMeterInput: odoController.text,
                            odoMeterOcrText: orderCubit.oddoText,
                            literInput: litersController.text,
                            literOcrText: orderCubit.litersText,
                            odoImage: orderCubit.odoImageFile as File,
                            litersImage: orderCubit.litersImageFile as File,
                            vehicleId: CacheHelper.getDataFromSharedPreference(
                                key: 'imageID'),
                          )
                              .then((_) {
                            if (state is NewOrderSuccessState) {
                              cubit.changeSheetContentToThirdSheet3();
                            } if (state is NewOrderErrorState) {
                              showToast(
                                  "Some errors happened , please try again",
                                  context);
                            }
                          });
                        } else {
                          showToast("Fill all Fields", context);
                        }
                      },
                      child: state is NewOrderLoadingState
                          ? const ProgressIndicatorWidget()
                          : const DefaultContainer(
                              borderRadius: 30.0,
                              color: AppColor.teal,
                              width: double.infinity,
                              height: 45.0,
                              widget: DefaultText(
                                text: "Confirm Order",
                                color: AppColor.white,
                                fontSize: 20.0,
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
