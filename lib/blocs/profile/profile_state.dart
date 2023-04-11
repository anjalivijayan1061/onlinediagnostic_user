part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final Map<String, dynamic> profileDetails;

  ProfileSuccessState({required this.profileDetails});
}

class ProfileFailureState extends ProfileState {
  final String message;

  ProfileFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}
