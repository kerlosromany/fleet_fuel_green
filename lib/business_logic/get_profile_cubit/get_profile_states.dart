abstract class GetProfileState {}

class GetProfileInitialState extends GetProfileState {}

class GetProfileLoadingState extends GetProfileState {}

class GetProfileSuccessState extends GetProfileState {}

class GetProfileErrorState extends GetProfileState {
  final String error;

  GetProfileErrorState({required this.error});
}


class UpdateProfileLoadingState extends GetProfileState {}

class UpdateProfileSuccessState extends GetProfileState {}

class UpdateProfileErrorState extends GetProfileState {
  final String error;

  UpdateProfileErrorState({required this.error});
}

