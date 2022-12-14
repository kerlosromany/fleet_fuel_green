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

