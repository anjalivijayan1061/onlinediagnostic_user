part of 'complaint_bloc.dart';

@immutable
abstract class ComplaintState {}

class ComplaintInitialState extends ComplaintState {}

class ComplaintLoadingState extends ComplaintState {}

class ComplaintSuccessState extends ComplaintState {
  final List<Map<String, dynamic>> complaints;

  ComplaintSuccessState({required this.complaints});
}

class ComplaintFailureState extends ComplaintState {
  final String message;

  ComplaintFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
