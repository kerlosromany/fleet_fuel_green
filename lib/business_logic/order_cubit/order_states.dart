abstract class OrderState {}

class OrderInitial extends OrderState {}

// make new order states
class NewOrderLoadingState extends OrderState {}

class NewOrderSuccessState extends OrderState {} 

class NewOrderErrorState extends OrderState {
  final String error;

  NewOrderErrorState({required this.error});
}

// Get user car states
class GetUserCarLoadingState extends OrderState {}

class GetUserCarSuccessState extends OrderState {}

class GetUserCarErrorState extends OrderState {
  final String error;

  GetUserCarErrorState({required this.error});
}


// car photo state
class ChangeCarPhotoState extends OrderState {}

class MobileVisionInitState extends OrderState {}

class MobileVisionTextOcrState extends OrderState {}

//////////////////
class RemoveSelectedVehicleIdState extends OrderState {}
class AddSelectedVehicleIdState extends OrderState {}
//////////////////

// Picke Image State
class SuccessPickImage extends OrderState {}
class ErrorPickImage extends OrderState {}
class GetRecognizedTextState extends OrderState {}

// generate code state
class GenerateCodeSuccessState extends OrderState {}
class GenerateCodeErrorState extends OrderState {}
class GenerateCodeLoadingState extends OrderState {}