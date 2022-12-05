import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  // password visibility Logic
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibiltyState());
  }

  bool isConfirmPassword = true;
  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    emit(ChangeConfirmPasswordVisibiltyState());
  }

  // change fuel station sheet content Logic
  void changeSheetContentToSecondSheet2() {
    emit(ChangeSheetContentToSecondSheet());
  }

  void changeSheetContentToThirdSheet3() {
    emit(ChangeSheetContentToThirdSheet());
  }
}
