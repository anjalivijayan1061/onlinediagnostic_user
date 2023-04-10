import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await Supabase.instance.client.auth.admin.createUser(
          AdminUserAttributes(
            email: event.email,
            password: event.password,
            phone: event.phone,
            userMetadata: {
              'status': 'active',
            },
          ),
        );
      } catch (e, s) {
        Logger().wtf("$e\n$s");
        emit(SignUpFailureState());
      }
    });
  }
}
