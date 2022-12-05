import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class FuelStationSheetContent3 extends StatelessWidget {
  const FuelStationSheetContent3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
              Image.asset(AppString.sQrCode),
              const SizedBox(height: 20),
              const DefaultContainer(
                borderRadius: 30.0,
                color: AppColor.teal,
                width: double.infinity,
                height: 45.0,
                widget: DefaultText(
                  text: "Genrated QR",
                  color: AppColor.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppString.sActor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
