import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';
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
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        if (state is ChangeSheetContentToSecondSheet) {
          return const FuelStationSheetContent2();
        }
        if (state is ChangeSheetContentToThirdSheet) {
          return const FuelStationSheetContent3();
        }
        return Container(
          decoration: const BoxDecoration(color: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350.0,
                    height: 60.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => const SizedBox(
                        child: Image(
                          image: AssetImage(AppString.sLic),
                          fit: BoxFit.fill,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                      itemCount: 5,
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
                        cubit.changeSheetContentToSecondSheet2();
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
