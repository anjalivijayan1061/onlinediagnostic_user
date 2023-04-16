part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {
  final List<Map<String, dynamic>> orders;

  OrdersSuccessState({required this.orders});
}

class OrdersFailureState extends OrdersState {
  final String message;

  OrdersFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
