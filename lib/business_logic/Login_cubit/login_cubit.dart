import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/dio_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';

import '../../constants/end_points.dart';
import '../../data/models/verify_phone_error_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // change password visibility Logic
  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  bool isChecked = false;
  void changeRemembereMeCheck() {
    isChecked = !isChecked;
    emit(ChangeRememberMEState());
  }

  IconData suffixIconConfirm = Icons.visibility_outlined;
  bool isConfirmPassword = true;
  void changePasswordConfirmVisibility() {
    isConfirmPassword = !isConfirmPassword;
    suffixIconConfirm = isConfirmPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordConfirmVisibilityState());
  }

  // Login Logic
  late LoginModel loginModel;
  userLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: epLOGIN,
      body: {
        "phone": "+2$phone",
        "password": password,
        "appKey": 524,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data!.user!.token);
      CacheHelper.saveDataSharedPreference(
          key: 'token', value: loginModel.data!.user!.token);
      emit(LoginSuccessState());
    }).catchError((error) {
      showToast(AppString.sLoginError, context);
      print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }

  // verify phone number Logic
  late LoginModel verifyPhoneModel;
  userVerifyPhone({
    required String phone,
    required BuildContext context,
  }) async {
    emit(VerifyPhoneLoadingState());
    try {
      Response res = await DioHelper.postData(
        url: epVERIFYPHONE,
        body: {
          "phone": phone,
          //"appKey": 524,
        },
      );
      print(res.data);
      verifyPhoneModel = LoginModel.fromJson(res.data);
      CacheHelper.saveDataSharedPreference(
          key: 'token', value: verifyPhoneModel.data!.user!.token);
      CacheHelper.saveDataSharedPreference(
          key: 'phone', value: verifyPhoneModel.data!.user!.phone);
      emit(VerifyPhoneSuccessState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        showToast(
          AppString.sSentOtpError,
          context,
        );
        emit(VerifyPhoneErrorState(error: e.message));
        return;
      }
    } catch (e) {
      print(e.toString());
      emit(VerifyPhoneErrorState(error: e.toString()));
    }
  }

  // resend otp code
  resendOTPCode({
    required String phone,
    required BuildContext context,
  }) async {
    emit(VerifyPhoneLoadingState());
    try {
      Response res = await DioHelper.postData(
        url: epVERIFYPHONE,
        body: {
          "phone": phone,
          //"appKey": 524,
        },
      );
      print(res.data);
      verifyPhoneModel = LoginModel.fromJson(res.data);
      CacheHelper.saveDataSharedPreference(
          key: 'token', value: verifyPhoneModel.data!.user!.token);
      showToast(
        verifyPhoneModel.data!.otp,
        context,
      );
      emit(VerifyPhoneSuccessState());
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        showToast(
          AppString.sSentOtpError,
          context,
        );
        emit(VerifyPhoneErrorState(error: e.message));
        return;
      }
    } catch (e) {
      print(e.toString());
      emit(VerifyPhoneErrorState(error: e.toString()));
    }
  }

  // send verified code
  late LoginModel verifiedModelAfterSendOtp;
  sendOtp({
    required String code,
    required BuildContext context,
  }) {
    emit(VerifyOtpLoadingState());
    DioHelper.postData(
      url: epVERIFYOTP,
      body: {
        "otp": code,
      },
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      print(value.data);
      verifiedModelAfterSendOtp = LoginModel.fromJson(value.data);
      print(verifiedModelAfterSendOtp.message);
      CacheHelper.saveDataSharedPreference(
          key: 'token', value: verifiedModelAfterSendOtp.data!.user!.token);
      emit(VerifyOtpSuccessState());
    }).catchError((error) {
      showToast("Try enter the code you recieved again", context);
      emit(VerifyOtpErrorState(error: error.toString()));
    });
  }

  // change otp code state
  String codeText = "";
  void changeCodeTextByAdding(value) {
    codeText = "$codeText$value";
    emit(ChangeCodeTextState());
  }

  void changeCodeTexttoEmpty(value) {
    codeText = "";
    emit(ChangeCodeTextToEmptyState());
  }

  //reset password logic

  late LoginModel modelAfterResetPassword;
  resetPassword({
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) {
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
      url: epRESETPASSWORD,
      body: {
        "password": password,
        "password_confirmation": confirmPassword,
      },
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      //print(value.data);
      modelAfterResetPassword = LoginModel.fromJson(value.data);
      //print(loginModel.data!.user!.token);
      CacheHelper.saveDataSharedPreference(
          key: 'token', value: modelAfterResetPassword.data!.user!.token);
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      showToast(AppString.sLoginError, context);
      print(error.toString());
      emit(ResetPasswordErrorState(error: error.toString()));
    });
  }
}
