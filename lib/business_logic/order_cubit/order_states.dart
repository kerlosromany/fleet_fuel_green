abstract class OrderState {}

class OrderInitial extends OrderState {}

// make new order states
class NewOrderLoadingState extends OrderInitial {}

class NewOrderSuccessState extends OrderInitial {} 

class NewOrderErrorState extends OrderInitial {
  final String error;

  NewOrderErrorState({required this.error});
}

// Get user car states
class GetUserCarLoadingState extends OrderInitial {}

class GetUserCarSuccessState extends OrderInitial {}

class GetUserCarErrorState extends OrderInitial {
  final String error;

  GetUserCarErrorState({required this.error});
}


// car photo state
class ChangeCarPhotoState extends OrderInitial {}

class MobileVisionInitState extends OrderInitial {}

class MobileVisionTextOcrState extends OrderInitial {}