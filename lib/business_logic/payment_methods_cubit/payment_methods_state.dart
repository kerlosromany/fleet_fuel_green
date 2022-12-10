abstract class PaymentMethodsState {}

class PaymentMethodsInitialState extends PaymentMethodsState {}

class PaymentMethodsLoadingState extends PaymentMethodsState {}

class PaymentMethodsSuccessState extends PaymentMethodsState {}

class PaymentMethodsErrorState extends PaymentMethodsState {
  final String error;

  PaymentMethodsErrorState({required this.error});
}

class PaymentMethodsFuelUpDailyState extends PaymentMethodsState {}

class PaymentMethodsFuelUpWeeklyState extends PaymentMethodsState {}

