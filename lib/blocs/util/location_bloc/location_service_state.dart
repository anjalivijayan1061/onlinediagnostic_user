part of 'location_service_bloc.dart';

@immutable
abstract class LocationServiceState {}

class LocationServiceInitialState extends LocationServiceState {}

class LocationServiceCheckingState extends LocationServiceState {}

class LocationServiceAskState extends LocationServiceState {}

class LocationServiceGrantedState extends LocationServiceState {}

class LocationServiceDeniedForeverState extends LocationServiceState {}

class LocationServiceDisabledState extends LocationServiceState {}
