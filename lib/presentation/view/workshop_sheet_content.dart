import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class WorkshopSheetContent extends StatelessWidget {
  const WorkshopSheetContent({Key? key, required this.reverse, this.controller})
      : super(key: key);
  final bool reverse;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(color: AppColor.white),
      padding: EdgeInsets.symmetric(horizontal: 0.06 * screenWidth),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 0.127 * screenWidth,
                    height: 0.048 * screenHeight,
                    child: Image.asset(AppString.sMask),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        text: 'Total Workshop',
                        color: AppColor.lightBlack,
                        fontSize: 0.04 * screenWidth,
                        fontWeight: FontWeight.w300,
                      ),
                      const SizedBox(height: 2.0),
                      DefaultText(
                        text: 'Discount up to 20\%',
                        color: AppColor.grey,
                        fontSize: 0.03 * screenWidth,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0.0145 * screenHeight),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.076 * screenWidth,
                      height: 0.0363 * screenHeight,
                      child: Image.asset(AppString.sStar),
                    ),
                    DefaultText(
                      text: '4.5 Stars',
                      color: AppColor.grey,
                      fontSize: 0.03 * screenWidth,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 0.018 * screenHeight),
          DefaultContainer(
            borderRadius: 30.0,
            color: AppColor.teal,
            width: 0.765 * screenWidth,
            height: 0.05 * screenHeight,
            widget: DefaultText(
              text: AppString.sGetDiscount,
              color: AppColor.white,
              fontSize: 0.051 * screenWidth,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
