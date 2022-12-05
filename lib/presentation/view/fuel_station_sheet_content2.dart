import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';

import '../styles/colors.dart';
import 'fuel_station_sheet_content3.dart';

class FuelStationSheetContent2 extends StatelessWidget {
  const FuelStationSheetContent2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultContainer(
                        color: AppColor.grey6,
                        width: 250,
                        height: 50,
                        borderRadius: 10,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(AppString.sFuel),
                            const DefaultText(
                              text: "1256888",
                              color: AppColor.red2,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppString.sInriaSerif,
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
                      const DefaultContainer(
                        borderRadius: 10,
                        color: AppColor.grey6,
                        height: 50,
                        width: 60,
                        widget: Image(
                          image: AssetImage(AppString.sCamera),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // third row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultContainer(
                        color: AppColor.grey6,
                        width: 250,
                        height: 50,
                        borderRadius: 10,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(AppString.sCounter),
                            const DefaultText(
                              text: "90",
                              color: AppColor.red2,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppString.sInriaSerif,
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
                      const DefaultContainer(
                        borderRadius: 10,
                        color: AppColor.grey6,
                        height: 50,
                        width: 60,
                        widget: Image(
                          image: AssetImage(AppString.sCamera),
                          fit: BoxFit.cover,
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
                      cubit.changeSheetContentToThirdSheet3();
                    },
                    child: const DefaultContainer(
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
        );
      },
    );
  }
}
