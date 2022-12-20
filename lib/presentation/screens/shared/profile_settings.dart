import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/get_profile_cubit/get_profile_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/get_profile_cubit/get_profile_states.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/default_container.dart';

import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../widget/default_text_field.dart';
import '../../widget/progress_indicator_widget.dart';

class ProfileSettingsScreen extends StatelessWidget {
  ProfileSettingsScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => GetProfileCubit()..getProfileData(),
      child: BlocConsumer<GetProfileCubit, GetProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GetProfileCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.grey6,
            appBar: AppBar(
              backgroundColor: AppColor.teal,
              title: const Text("Profile Settings"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
            drawer: const Drawer(),
            body: state is GetProfileLoadingState
                ? const ProgressIndicatorWidget()
                : Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.038 * screenWidth),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  // Edit Profile Photo
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 0.16 * screenWidth,
                                        backgroundColor: Colors.green,
                                      ),
                                      Positioned(
                                        top: 0.1 * screenHeight,
                                        left: 0.2 * screenWidth,
                                        child: CircleAvatar(
                                          backgroundColor: AppColor.white,
                                          radius: 0.05 * screenWidth,
                                          child: CircleAvatar(
                                            radius: 0.045 * screenWidth,
                                            backgroundColor: AppColor.red,
                                            child: FittedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.edit_outlined,
                                                      color: AppColor.white,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "...",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.018 * screenHeight),
                                  const Text("Kerolos romany dawood"),
                                  const Text("مدرسة فيوتشر"),
                                  SizedBox(height: 0.05 * screenHeight),
                                  //Name
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    isSearch: false,
                                    img: AppString.sPasswordPhoto1,
                                    hintTxt:
                                        cubit.loginModel.data!.user!.name ??
                                            "Name",
                                    color: AppColor.grey3,
                                    isPassword: false,
                                    textInputType: TextInputType.name,
                                    textEditingController: nameController,
                                    validate: (value) {},
                                  ),
                                  SizedBox(height: 0.018 * screenHeight),
                                  // Bus Info
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    isSearch: false,
                                    img: AppString.sCar,
                                    hintTxt: "1234 | م س",
                                    color: AppColor.grey3,
                                    isPassword: false,
                                    textInputType: TextInputType.text,
                                    textEditingController: addressController,
                                    validate: (value) {},
                                  ),
                                  SizedBox(height: 0.018 * screenHeight),
                                  // Phone number
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    img: AppString.sSmartPhone,
                                    hintTxt:
                                        cubit.loginModel.data!.user!.phone ??
                                            "Phone Number",
                                    color: AppColor.grey3,
                                    isSearch: false,
                                    isPassword: false,
                                    textInputType: TextInputType.phone,
                                    textEditingController: phoneController,
                                    validate: (value) {},
                                  ),
                                  SizedBox(height: 0.018 * screenHeight),
                                  // Email
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    img: AppString.sEmail,
                                    hintTxt:
                                        cubit.loginModel.data!.user!.email ??
                                            "Email",
                                    color: AppColor.grey3,
                                    isPassword: false,
                                    textInputType: TextInputType.emailAddress,
                                    textEditingController: emailController,
                                    isSearch: false,
                                    validate: (value) {},
                                  ),
                                  
                                  SizedBox(height: 0.018 * screenHeight),
                                  // password
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    color: AppColor.grey3,
                                    hintTxt: "Password",
                                    img: AppString.sPasswordPhoto1,
                                    isPassword: true,
                                    textInputType: TextInputType.text,
                                    isSearch: false,
                                    textEditingController: passwordController,
                                    validate: (value) {
                                      if (value.isNotEmpty) {
                                        if (value.length < 9) {
                                          return "Password must be 9 characters or more";
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(height: 0.018 * screenHeight),
                                  // confirm password
                                  DefaultTextField(
                                    height: 0.06 * screenHeight,
                                    color: AppColor.grey3,
                                    hintTxt: "Confirm Password",
                                    img: AppString.sPasswordPhoto1,
                                    isPassword: true,
                                    textInputType: TextInputType.text,
                                    isSearch: false,
                                    textEditingController:
                                        passwordConfirmController,
                                    validate: (value) {
                                      if (value.isNotEmpty) {
                                        if (value.length < 9) {
                                          return "Password must be 9 characters or more";
                                        }
                                      }
                                      if (value != passwordController.text) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 0.06 * screenHeight),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.updateProfileData(
                                              password: passwordController.text,
                                              confirmPassword:
                                                  passwordConfirmController
                                                      .text,
                                              //birth: birthController.text,
                                              email: emailController.text,
                                              context: context,
                                            );
                                          }
                                        },
                                        child: state
                                                is UpdateProfileLoadingState
                                            ? const ProgressIndicatorWidget()
                                            : DefaultContainer(
                                                color: AppColor.teal
                                                    .withOpacity(0.7),
                                                borderRadius: 10,
                                                width: 0.255 * screenWidth,
                                                height: 0.06 * screenHeight,
                                                widget: const Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      color: AppColor.white),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.06 * screenHeight,
                          child: Image.asset(AppString.sBackGround),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
