import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../widget/default_container.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';

class ResendPasswordScreen extends StatelessWidget {
   ResendPasswordScreen({Key? key}) : super(key: key);
  TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
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
                  img: AppString.sPasswordPhoto1,
                  isPassword: true,
                  textInputType: TextInputType.text,
                  textEditingController: passwordController,
                  validate: (value){},
                ),
                SizedBox(height: 0.02 * screenHeight),
                DefaultTextField(

                  height: 0.06 * screenHeight,
                  color: AppColor.grey3,
                  hintTxt: "Confirm Password",
                  img: AppString.sPasswordPhoto1,
                  isPassword: true,
                  textInputType: TextInputType.text,
                  textEditingController: passwordConfirmController,
                  validate: (value){},
                ),
                 SizedBox(height: 0.042 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    DefaultContainer(
                      color: AppColor.teal,
                      width: 0.51 * screenWidth,
                      height: 0.06*screenHeight,
                      borderRadius: 10,
                      widget: DefaultText(
                          text: AppString.sResetPassword,
                          color: AppColor.white,
                          fontSize: 0.04 * screenWidth,
                          fontWeight: FontWeight.w300,),
                    ),
                  ],
                ),
                 SizedBox(height: 0.278 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
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
  }
}
