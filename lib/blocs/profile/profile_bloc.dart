import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      try {
        if (event is GetProfileEvent) {
          Map<String, dynamic> profileDetails = {};
          User? user = supabaseClient.auth.currentUser;

          if (user != null) {
            profileDetails = {
              'email': user.email,
              'phone': user.phone,
            };

            emit(
              ProfileSuccessState(
                profileDetails: profileDetails,
              ),
            );
          } else {
            emit(ProfileFailureState());
          }
        } else if (event is UpdateProfileEvent) {
          UserAttributes userAttributes = UserAttributes(
            email: event.email,
            phone: event.phone,
          );
          if (event.password != null) {
            userAttributes.password = event.password;
          }
          await supabaseClient.auth.updateUser(
            userAttributes,
          );

          add(GetProfileEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ProfileFailureState());
      }
    });
  }
}
