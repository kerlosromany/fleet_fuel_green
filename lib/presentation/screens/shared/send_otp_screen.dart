import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_text.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';

import '../../router/app_routers_names.dart';
import '../../widget/text_field_otp.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(otpCode);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccessState) {
            Navigator.pushNamed(context, AppRouterNames.rHome);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: AppColor.grey6,
            appBar: AppBar(
              backgroundColor: AppColor.teal,
              title: const Text("Forgot Password"),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.038 * screenWidth),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0.19 * screenHeight),
                      DefaultText(
                        color: AppColor.red,
                        fontSize: 0.05 * screenWidth,
                        text: AppString.sVerify,
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(height: 0.018 * screenHeight),
                      DefaultText(
                        color: AppColor.grey,
                        fontSize: 0.038 * screenWidth,
                        text: AppString.sVerifyInfo,
                        fontWeight: FontWeight.w300,
                      ),
                      SizedBox(height: 0.048 * screenHeight),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     DefaultContainer(
                      //       color: AppColor.white,
                      //       width: 50,
                      //       height: 50,
                      //       widget: Text("5"),
                      //       borderRadius: 10,
                      //     ),
                      //     SizedBox(width: 10),
                      //     DefaultContainer(
                      //       color: AppColor.white,
                      //       width: 50,
                      //       height: 50,
                      //       widget: Text("5"),
                      //       borderRadius: 10,
                      //     ),
                      //     SizedBox(width: 10),
                      //     DefaultContainer(
                      //       color: AppColor.white,
                      //       width: 50,
                      //       height: 50,
                      //       widget: Text("5"),
                      //       borderRadius: 10,
                      //     ),
                      //     SizedBox(width: 10),
                      //     DefaultContainer(
                      //       color: AppColor.white,
                      //       width: 50,
                      //       height: 50,
                      //       widget: Text("5"),
                      //       borderRadius: 10,
                      //     ),
                      //   ],
                      // ),
                      //////////////////////////////////
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     TextFieldOtp(
                      //       first: true,
                      //       last: false,
                      //       cubit: cubit,
                      //     ),
                      //     TextFieldOtp(
                      //       first: true,
                      //       last: false,
                      //       cubit: cubit,
                      //     ),
                      //     TextFieldOtp(
                      //       first: true,
                      //       last: false,
                      //       cubit: cubit,
                      //     ),
                      //     TextFieldOtp(
                      //       first: true,
                      //       last: false,
                      //       cubit: cubit,
                      //     ),
                      //   ],
                      // ),
                      //////////////////////////////////////
                      OtpTextField(
                        fieldWidth: 50,
                        borderRadius: BorderRadius.circular(10),
                        numberOfFields: 4,
                        borderColor: AppColor.white,
                        decoration: const InputDecoration(
                          fillColor: AppColor.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.white, width: 0),
                          ),
                          enabled: true,
                        ),
                        borderWidth: 0,
                        fillColor: AppColor.white,
                        filled: true,
                        showFieldAsBox: true,
                        keyboardType: TextInputType.number,
                        disabledBorderColor: AppColor.white,
                        enabledBorderColor: AppColor.white,
                        enabled: true,
                        cursorColor: AppColor.teal,
                        focusedBorderColor: AppColor.white,
                        onCodeChanged: (String code) {
                          cubit.changeCodeTextByAdding(code);
                          print("code is $code");
                          print(cubit.codeText);
                          if (code.isEmpty) {
                            cubit.changeCodeTexttoEmpty(code);
                            print(cubit.codeText);
                          }
                        },
                      ),
                      SizedBox(height: 0.06 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            text: AppString.sCodeInfo,
                            color: AppColor.grey2,
                            fontSize: 0.035 * screenWidth,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.resendOTPCode(
                                phone: CacheHelper.getDataFromSharedPreference(
                                    key: 'phone'),
                                context: context,
                              );
                            },
                            child: DefaultText(
                              text: AppString.sResend,
                              color: AppColor.red,
                              fontSize: 0.045 * screenWidth,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.02 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.sendOtp(
                                  code: cubit.codeText, context: context);
                            },
                            child: state is VerifyOtpLoadingState
                                ? const ProgressIndicatorWidget()
                                : DefaultContainer(
                                    color: AppColor.teal,
                                    width: 0.51 * screenWidth,
                                    height: 0.06 * screenHeight,
                                    borderRadius: 10,
                                    widget: DefaultText(
                                      text: AppString.verify,
                                      color: AppColor.white,
                                      fontSize: 0.04 * screenWidth,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.278 * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            text: AppString.sTry,
                            color: AppColor.grey3,
                            fontSize: 0.035 * screenWidth,
                            fontWeight: FontWeight.w400,
                          ),
                          DefaultText(
                            text: AppString.sLogin,
                            color: AppColor.red,
                            fontSize: 0.045 * screenWidth,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
