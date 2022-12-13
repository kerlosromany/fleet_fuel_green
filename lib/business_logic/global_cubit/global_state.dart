part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

// password visibility States
class ChangePasswordVisibiltyState extends GlobalState {}

class ChangeConfirmPasswordVisibiltyState extends GlobalState {}

// change fuel station sheet content Logic
class ChangeSheetContentToSecondSheet extends GlobalState {}

class ChangeSheetContentToThirdSheet extends GlobalState {}

// change bottom nav bar states
class ChangeCurrentIndexState extends GlobalState {}

// ocr states changes
class ChangeControllersState extends GlobalState {}

class OdoControllerSuccessState extends GlobalState {}

class OdoControllerErrorState extends GlobalState {}

class ChangePhotoState extends GlobalState {}

////////
class LitersControllerSuccessState extends GlobalState {}

class LitersControllerErrorState extends GlobalState {}

// Get user car states
class GetUserCarLoadingState extends GlobalState {}

class GetUserCarSuccessState extends GlobalState {}

class GetUserCarErrorState extends GlobalState {
  final String error;

  GetUserCarErrorState({required this.error});
}

// car photo state
class ChangeCarPhotoState extends GlobalState {}

// make new order states
class NewOrderLoadingState extends GlobalState {}

class NewOrderSuccessState extends GlobalState {}

class NewOrderErrorState extends GlobalState {
  final String error;

  NewOrderErrorState({required this.error});
}


