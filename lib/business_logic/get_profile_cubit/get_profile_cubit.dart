import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/dio_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';

import '../../constants/end_points.dart';
import '../../constants/strings.dart';
import '../../presentation/widget/toast.dart';
import 'get_profile_states.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitialState());

  static GetProfileCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  getProfileData() {
    emit(GetProfileLoadingState());
    DioHelper.getData(
      url: epGETPROFILE,
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      print("data before update ${value.data}");
      loginModel = LoginModel.fromJson(value.data);
      //print(value.data);
      // print(loginModel.message);
      // print(loginModel.data!.user!.email);
      emit(GetProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState(error: error.toString()));
    });
  }

  late LoginModel loginModelAfterUpdate;
  updateProfileData({
    required String password,
    required String confirmPassword,
    required String email,
    required BuildContext context,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.postData(
      url: epUPDATEPROFILE,
      body: {
        "password": password,
        "password_confirmation": confirmPassword,
        "email": email,
      },
      token: "Bearer ${CacheHelper.getDataFromSharedPreference(key: 'token')}",
    ).then((value) {
      print("data after update ${value.data}");
      loginModel = LoginModel.fromJson(value.data);
      //print(loginModel.data!.user!.token);
      // CacheHelper.getDataFromSharedPreference(
      //     key: 'token');
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      showToast(AppString.sLoginError, context);
      emit(UpdateProfileErrorState(error: error.toString()));
    });
  }
}
