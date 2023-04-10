part of 'get_all_tests_bloc.dart';

@immutable
abstract class GetAllTestsState {}

class GetAllTestsInitialState extends GetAllTestsState {}

class GetAllTestsLoadingState extends GetAllTestsState {}

class GetAllTestsSuccessState extends GetAllTestsState {
  final List<Map<String, dynamic>> tests;

  GetAllTestsSuccessState({required this.tests});
}

class GetAllTestsFailureState extends GetAllTestsState {
  final String message;

  GetAllTestsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
