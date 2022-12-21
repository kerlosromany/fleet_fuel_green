abstract class LoginState {}

class LoginInitialState extends LoginState {}

// Login States

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

// change password visibility Logic

class ChangePasswordVisibilityState extends LoginState{}
class ChangePasswordConfirmVisibilityState extends LoginState{}
class ChangeRememberMEState extends LoginState{}

// Verify Phone States
class VerifyPhoneLoadingState extends LoginState {}

class VerifyPhoneSuccessState extends LoginState {}

class VerifyPhoneErrorState extends LoginState {
  final String error;

  VerifyPhoneErrorState({required this.error});
}

// Sent Code States
class VerifyOtpLoadingState extends LoginState {}

class VerifyOtpSuccessState extends LoginState {}

class VerifyOtpErrorState extends LoginState {
  final String error;

  VerifyOtpErrorState({required this.error});
}

class ChangeCodeTextState extends LoginState {}
class ChangeCodeTextToEmptyState extends LoginState {}


// reset password States

class ResetPasswordLoadingState extends LoginState {}

class ResetPasswordSuccessState extends LoginState {}

class ResetPasswordErrorState extends LoginState {
  final String error;

  ResetPasswordErrorState({required this.error});
}
