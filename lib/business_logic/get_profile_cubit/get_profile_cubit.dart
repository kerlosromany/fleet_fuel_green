import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/Login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/dio_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';

import '../../constants/end_points.dart';
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
}
