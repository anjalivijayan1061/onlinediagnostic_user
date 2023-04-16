part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {
  final String status;
  final int? patientId;

  GetOrdersEvent({
    this.status = 'pending',
    this.patientId,
  });
}

class AddOrderEvent extends OrdersEvent {
  final int patientId;
  final PlatformFile? prescription;
  final List<Map<String, dynamic>> tests;

  AddOrderEvent({
    required this.patientId,
    this.prescription,
    required this.tests,
  });
}

class DeleteOrderEvent extends OrdersEvent {
  final int orderId;

  DeleteOrderEvent({required this.orderId});
}
