import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';

import '../../../constants/strings.dart';
import '../../router/app_routers_names.dart';
import '../../styles/colors.dart';
import '../../widget/default_container.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';
import '../../widget/progress_indicator_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            Navigator.pushNamed(context, AppRouterNames.rHome);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.181 * screenHeight),
                        DefaultText(
                          color: AppColor.red,
                          fontSize: 0.05 * screenWidth,
                          text: AppString.sResetPass,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: 0.018 * screenHeight),
                        DefaultText(
                          color: AppColor.grey,
                          fontSize: 0.038 * screenWidth,
                          text: AppString.sResetPassInfo,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        DefaultTextField(
                          height: 0.06 * screenHeight,
                          color: AppColor.grey3,
                          hintTxt: "Password",
                          isSearch: false,
                          img: AppString.sPasswordPhoto1,
                          isPassword: cubit.isPassword,
                          textInputType: TextInputType.visiblePassword,
                          textEditingController: passwordController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Password must be not empty";
                            } else if (value.length < 9) {
                              return "Password must be 9 characters or more";
                            }
                            return null;
                          },
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          iconData: cubit.suffixIcon,
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        DefaultTextField(
                          height: 0.06 * screenHeight,
                          color: AppColor.grey3,
                          hintTxt: "Confirm Password",
                          img: AppString.sPasswordPhoto1,
                          isPassword: cubit.isConfirmPassword,
                          textInputType: TextInputType.visiblePassword,
                          isSearch: false,
                          textEditingController: passwordConfirmController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Password must be not empty";
                            } else if (value.length < 9) {
                              return "Password must be 9 characters or more";
                            } else if (value != passwordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          suffixPressed: () {
                            cubit.changePasswordConfirmVisibility();
                          },
                          iconData: cubit.suffixIconConfirm,
                        ),
                        SizedBox(height: 0.042 * screenHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.resetPassword(
                                    password: passwordController.text,
                                    confirmPassword:
                                        passwordConfirmController.text,
                                    context: context,
                                  );
                                }
                              },
                              child: state is ResetPasswordLoadingState
                                  ? const ProgressIndicatorWidget()
                                  : DefaultContainer(
                                      color: AppColor.teal,
                                      width: 0.51 * screenWidth,
                                      height: 0.06 * screenHeight,
                                      borderRadius: 10,
                                      widget: DefaultText(
                                        text: AppString.sResetPassword,
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
            ),
          );
        },
      ),
    );
  }
}
