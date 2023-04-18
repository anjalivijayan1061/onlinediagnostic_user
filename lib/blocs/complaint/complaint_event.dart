part of 'complaint_bloc.dart';

@immutable
abstract class ComplaintEvent {}

class AddComplaintEvent extends ComplaintEvent {
  final String complaint;
  final int testBookingId;

  AddComplaintEvent({
    required this.complaint,
    required this.testBookingId,
  });
}

class DeleteComplaintEvent extends ComplaintEvent {
  final int complaintId;

  DeleteComplaintEvent({required this.complaintId});
}

class GetAllComplaintEvent extends ComplaintEvent {
  final String? query;

  GetAllComplaintEvent({this.query});
}
