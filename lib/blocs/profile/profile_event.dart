part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String email, phone;
  final String? password;

  UpdateProfileEvent({
    required this.email,
    required this.phone,
    this.password,
  });
}

class GetProfileEvent extends ProfileEvent {}
