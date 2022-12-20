import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../business_logic/order_cubit/order_cubit.dart';
import '../styles/colors.dart';
import 'default_text.dart';

class CarPhotoWidget extends StatelessWidget {
  final String carNumber;
 CarPhotoWidget({Key? key , required this.carNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderCubit = OrderCubit.get(context);
    return Container(
      // width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColor.black,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: AppColor.red3,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(13),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DefaultText(
                    text: "Egypt",
                    color: AppColor.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
                DefaultText(
                    text: "مصر",
                    color: AppColor.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               DefaultText(
                  text: carNumber,
                  color: AppColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 4,
                  height: 50,
                  color: AppColor.black,
                ),
              ),
              const DefaultText(
                  text: "م س",
                  color: AppColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }
}