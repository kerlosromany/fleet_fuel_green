import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/send_OTP_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../../constants/strings.dart';
import 'package:sizer/sizer.dart';
import '../../styles/colors.dart';
import '../../widget/default_container.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  VerifyPhoneNumberScreen({Key? key}) : super(key: key);
  TextEditingController phoneSendOtpController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          var cubit = LoginCubit.get(context);
          if (state is VerifyPhoneSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendOtpScreen(),
                ));
            showToast(cubit.verifyPhoneModel.data!.otp, context);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.teal,
              title: const Text(AppString.sForgotPassword),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 17.sp, horizontal: 12.sp),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultText(
                          color: AppColor.grey3,
                          fontSize: 17.sp,
                          text: AppString.sSendOtp,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        DefaultContainer(
                          color: Colors.transparent,
                          borderRadius: 10,
                          width: 400,
                          height: 150,
                          widget: Image.asset(AppString.sDataSecurity),
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              color: AppColor.red,
                              fontSize: 17.sp,
                              text: AppString.sVerify,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(height: 0.018 * screenHeight),
                            DefaultText(
                              color: AppColor.grey,
                              fontSize: 12.sp,
                              text: AppString.sVerifyInfo,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        DefaultTextField(
                          height: 0.06 * screenHeight,
                          img: AppString.sSmartPhone,
                          hintTxt: "Phone Number",
                          color: AppColor.grey3,
                          isPassword: false,
                          isSearch: false,
                          textInputType: TextInputType.phone,
                          textEditingController: phoneSendOtpController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "please enter your phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userVerifyPhone(
                                  phone: phoneSendOtpController.text,
                                  context: context);
                            }
                          },
                          child: state is VerifyPhoneLoadingState
                              ? const ProgressIndicatorWidget()
                              : DefaultContainer(
                                  color: AppColor.teal.withOpacity(0.6),
                                  borderRadius: 10,
                                  width: 0.51 * screenWidth,
                                  height: 0.06 * screenHeight,
                                  widget: DefaultText(
                                    text: AppString.sSendOtp,
                                    color: AppColor.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              text: AppString.sTry,
                              color: AppColor.grey3,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            DefaultText(
                              text: AppString.sLogin,
                              color: AppColor.red,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
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
