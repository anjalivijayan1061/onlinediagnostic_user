import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_service_event.dart';
part 'location_service_state.dart';

class LocationServiceBloc
    extends Bloc<LocationServiceEvent, LocationServiceState> {
  LocationServiceBloc() : super(LocationServiceInitialState()) {
    on<LocationServiceEvent>((event, emit) async {
      emit(LocationServiceCheckingState());

      if (event is LocationServiceAskEvent) {
        switch (await Geolocator.requestPermission()) {
          case LocationPermission.always:
            emit(LocationServiceGrantedState());
            break;

          case LocationPermission.whileInUse:
            emit(LocationServiceGrantedState());
            break;

          case LocationPermission.denied:
            emit(LocationServiceAskState());
            break;

          case LocationPermission.deniedForever:
            emit(LocationServiceDeniedForeverState());
            break;

          case LocationPermission.unableToDetermine:
            emit(LocationServiceAskState());
            break;

          default:
            emit(LocationServiceAskState());
            break;
        }
      } else {
        if (await Geolocator.isLocationServiceEnabled()) {
          switch (await Geolocator.checkPermission()) {
            case LocationPermission.always:
              emit(LocationServiceGrantedState());
              break;

            case LocationPermission.whileInUse:
              emit(LocationServiceGrantedState());
              break;

            case LocationPermission.denied:
              emit(LocationServiceAskState());
              break;

            case LocationPermission.deniedForever:
              emit(LocationServiceDeniedForeverState());
              break;

            case LocationPermission.unableToDetermine:
              emit(LocationServiceAskState());
              break;

            default:
              emit(LocationServiceAskState());
              break;
          }
        } else {
          emit(LocationServiceDisabledState());
        }
      }
    });
  }
}
