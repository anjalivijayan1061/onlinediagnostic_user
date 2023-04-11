part of 'location_service_bloc.dart';

@immutable
abstract class LocationServiceEvent {}

class LocationServiceCheckEvent implements LocationServiceEvent {}

class LocationServiceAskEvent implements LocationServiceEvent {}
