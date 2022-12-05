import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class BalanceItem extends StatelessWidget {
  const BalanceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 0.03 * screenHeight),
      child: Center(
        child: DefaultContainer(
            borderRadius: 10.0,
            color: AppColor.white,
            width: 0.64 * screenWidth,
            height: 0.12 * screenHeight,
            widget: Padding(
              padding: EdgeInsets.all(0.0128 * screenWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      DefaultContainer(
                        borderRadius: 10.0,
                        color: Colors.transparent,
                        width: 0.128 * screenWidth,
                        height: 0.036 * screenHeight,
                        widget: const ImageIcon(
                          AssetImage(AppString.sDownLoad),
                          color: AppColor.green,
                        ),
                      ),
                      DefaultText(
                        text: '5866 Liter',
                        color: AppColor.green,
                        fontSize: 0.038 * screenWidth,
                        fontWeight: FontWeight.w500,
                      ),
                      DefaultText(
                        text: 'Incoming Fuelup',
                        color: AppColor.tealBackGround,
                        fontSize: 0.038 * screenWidth,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  DefaultContainer(
                    borderRadius: 10.0,
                    widget: const SizedBox(),
                    color: AppColor.green,
                    width: 1.0,
                    height: 0.07 * screenHeight,
                  ),
                  Column(
                    children: [
                      DefaultContainer(
                        borderRadius: 10.0,
                        color: Colors.transparent,
                        width: 0.128 * screenWidth,
                        height: 0.036 * screenHeight,
                        widget: const ImageIcon(
                          AssetImage(AppString.sUpLoad),
                          color: AppColor.green,
                        ),
                      ),
                      DefaultText(
                        text: '568 Liter',
                        color: AppColor.green,
                        fontSize: 0.05 * screenWidth,
                        fontWeight: FontWeight.w500,
                      ),
                      DefaultText(
                        text: 'Usage Fuelup',
                        color: AppColor.tealBackGround,
                        fontSize: 0.0255 * screenWidth,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
