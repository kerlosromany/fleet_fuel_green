import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../styles/colors.dart';
import '../widget/default_container.dart';
import '../widget/default_text.dart';

class CurrentBalanceItem extends StatelessWidget {
  const CurrentBalanceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: EdgeInsets.only(bottom: 0.16 * screenHeight),
      child: Center(
        child: DefaultContainer(
            borderRadius: 10.0,
            color: AppColor.teal,
            width: 0.77 * screenWidth,
            height: 0.12 * screenHeight,
            widget: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultText(
                      text: 'Current balance',
                      color: AppColor.white,
                      fontSize: 0.038 * screenWidth,
                      fontWeight: FontWeight.w500,
                    ),
                    DefaultText(
                      text: '100 Liter',
                      color: AppColor.white,
                      fontSize: 0.077 * screenWidth,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const Image(image: AssetImage(AppString.sPyramids)),
              ],
            )),
      ),
    );
  }
}
