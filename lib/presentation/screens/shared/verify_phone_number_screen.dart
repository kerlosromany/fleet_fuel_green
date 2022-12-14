import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/send_OTP_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/progress_indicator_widget.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../../constants/strings.dart';
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const DefaultText(
                          color: AppColor.grey3,
                          fontSize: 20,
                          text: AppString.sSendOtp,
                          fontWeight: FontWeight.w300,
                        ),
                        const SizedBox(height: 20.0),
                        DefaultContainer(
                          color: Colors.transparent,
                          borderRadius: 10,
                          width: 400,
                          height: 150,
                          widget: Image.asset(AppString.sDataSecurity),
                        ),
                        const SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            DefaultText(
                              color: AppColor.red,
                              fontSize: 20,
                              text: AppString.sVerify,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(height: 15),
                            DefaultText(
                              color: AppColor.grey,
                              fontSize: 15,
                              text: AppString.sVerifyInfo,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        DefaultTextField(
                          height: 0.06 * screenHeight,
                          img: AppString.sSmartPhone,
                          hintTxt: "Phone Number",
                          color: AppColor.grey3,
                          isPassword: false,
                          textInputType: TextInputType.phone,
                          textEditingController: phoneSendOtpController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "please enter your phone number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
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
                                  width: 200,
                                  height: 50,
                                  widget: const DefaultText(
                                    text: AppString.sSendOtp,
                                    color: AppColor.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            DefaultText(
                              text: AppString.sTry,
                              color: AppColor.grey3,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            DefaultText(
                              text: AppString.sLogin,
                              color: AppColor.red,
                              fontSize: 18,
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
