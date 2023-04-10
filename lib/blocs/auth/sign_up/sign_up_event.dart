part of 'sign_up_bloc.dart';

class SignUpEvent {
  final String email, password, phone;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.phone,
  });
}
