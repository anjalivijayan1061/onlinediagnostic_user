part of 'patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class AddPatientEvent extends PatientEvent {
  final String name, phone, address, city, state, district, gender;
  final DateTime dob;
  final double latitude, longitude;

  AddPatientEvent({
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.district,
    required this.gender,
    required this.dob,
    required this.latitude,
    required this.longitude,
  });
}

class EditPatientEvent extends PatientEvent {
  final String name, phone, address, city, state, district, gender;
  final DateTime dob;
  final int patientId;
  final double latitude, longitude;

  EditPatientEvent({
    required this.name,
    required this.address,
    required this.phone,
    required this.patientId,
    required this.dob,
    required this.city,
    required this.state,
    required this.district,
    required this.gender,
    required this.latitude,
    required this.longitude,
  });
}

class DeletePatientEvent extends PatientEvent {
  final int patientId;

  DeletePatientEvent({required this.patientId});
}

class GetAllPatientEvent extends PatientEvent {
  final String? query;

  GetAllPatientEvent({this.query});
}
