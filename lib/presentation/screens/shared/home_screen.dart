import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/payment_method_screen.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../view/default_grapping.dart';
import '../../view/fuel_station_sheet_content.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                    color: AppColor.grey4,
                    blurRadius: 25,
                    offset: Offset(10, 10)),
              ],
            ),
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cubit.changeCurrentIndex(0);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cubit.currentIndex == 0
                            ? AppColor.teal
                            : AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: cubit.currentIndex == 0 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            const AssetImage(AppString.sHome),
                            color: cubit.currentIndex == 0
                                ? AppColor.white
                                : AppColor.grey9,
                          ),
                          const DefaultText(
                            text: "Home",
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppString.sActor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cubit.changeCurrentIndex(1);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cubit.currentIndex == 1
                            ? AppColor.teal
                            : AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: cubit.currentIndex == 1 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                        children:  [
                          ImageIcon(
                            const AssetImage(AppString.sWallet),
                            color: cubit.currentIndex == 1
                                ? AppColor.white
                                : AppColor.grey9,
                          ),
                          const DefaultText(
                            text: "Wallet",
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppString.sActor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cubit.changeCurrentIndex(2);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cubit.currentIndex == 2
                            ? AppColor.teal
                            : AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: cubit.currentIndex == 2 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                        children:  [
                          ImageIcon(
                            const AssetImage(AppString.sOrders),
                            color: cubit.currentIndex == 2
                                ? AppColor.white
                                : AppColor.grey9,
                          ),
                          const DefaultText(
                            text: "Orders",
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppString.sActor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cubit.changeCurrentIndex(3);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cubit.currentIndex == 3
                            ? AppColor.teal
                            : AppColor.white,
                      ),
                      child: Row(
                        mainAxisAlignment: cubit.currentIndex == 3 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                        children:  [
                          ImageIcon(
                            const AssetImage(AppString.sUser),
                            color: cubit.currentIndex == 3
                                ? AppColor.white
                                : AppColor.grey9,
                          ),
                          const DefaultText(
                            text: "Profile",
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppString.sActor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
