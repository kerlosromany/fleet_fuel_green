import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/payment_methods_cubit/payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitialState());

  static PaymentMethodsCubit get(context) => BlocProvider.of(context);

  bool isDaily = true;
  bool isWeekly = false;
  void changeFuelUpDailyStates() {
    isDaily = true;
    isWeekly = false;
    emit(PaymentMethodsFuelUpDailyState());
  }
  void changeFuelUpWeeklyStates() {
    isDaily = false;
    isWeekly = true;
    emit(PaymentMethodsFuelUpWeeklyState());
  }
  
}
