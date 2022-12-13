import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/router/app_router.dart';
import 'package:magdsoft_flutter_structure/presentation/router/app_routers_names.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../widget/default_container.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';
import '../../widget/progress_indicator_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController phoneLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppRouterNames.rHome);
            
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.teal,
              title: const DefaultText(
                color: AppColor.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                text: AppString.sLogin,
                fontFamily: AppString.sActor,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.024 * screenHeight,
                    horizontal: 0.038 * screenWidth,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultText(
                          color: AppColor.grey3,
                          fontSize: 0.062 * screenWidth,
                          text: 'Welcome',
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 0.024 * screenHeight),
                        DefaultContainer(
                          color: Colors.transparent,
                          width: double.infinity,
                          borderRadius: 10,
                          height: 0.181 * screenHeight,
                          widget: Image.asset(AppString.sDataSecurity),
                        ),
                        SizedBox(height: 0.024 * screenHeight),
                        // Phone number
                        DefaultTextField(
                          textEditingController: phoneLoginController,
                          isSearch: false,
                          height: 0.07 * screenHeight,
                          img: AppString.sSmartPhone,
                          hintTxt: AppString.sPhoneNumber,
                          color: AppColor.grey3,
                          isPassword: false,
                          textInputType: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "please enter your phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        // password
                        DefaultTextField(
                          height: 0.07 * screenHeight,
                          color: AppColor.grey3,
                          isSearch: false,
                          hintTxt: AppString.sPassword,
                          img: AppString.sPasswordPhoto1,
                          isPassword: cubit.isPassword,
                          textInputType: TextInputType.visiblePassword,
                          textEditingController: passwordLoginController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Password must be not empty";
                            } else if (value.length < 6) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const ImageIcon(AssetImage(AppString.sCheck)),
                                SizedBox(width: 0.0178 * screenWidth),
                                DefaultText(
                                  color: AppColor.grey3,
                                  fontSize: 0.0408 * screenWidth,
                                  text: AppString.sRememberMe,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRouterNames.rResetPasswordScreen);
                              },
                              child: DefaultText(
                                color: AppColor.grey3,
                                fontSize: 0.0408 * screenWidth,
                                text: AppString.sForgotPassword,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.02 * screenHeight),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                phone: phoneLoginController.text,
                                password: passwordLoginController.text,
                                context: context,
                              );
                            }
                          },
                          child: state is LoginLoadingState
                              ? const ProgressIndicatorWidget()
                              : DefaultContainer(
                                  color: AppColor.teal.withOpacity(0.6),
                                  width: 0.51 * screenWidth,
                                  borderRadius: 10,
                                  height: 0.06 * screenHeight,
                                  widget: DefaultText(
                                    text: AppString.sLogin,
                                    color: AppColor.white,
                                    fontSize: 0.0383 * screenWidth,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppString.sActor,
                                  ),
                                ),
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
