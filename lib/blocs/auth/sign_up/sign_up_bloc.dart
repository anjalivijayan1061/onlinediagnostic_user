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
            emailConfirm: true,
            userMetadata: {
              'status': 'active',
            },
          ),
        );

        await Supabase.instance.client.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );

        emit(SignUpSuccessState());
      } on AuthException catch (e, s) {
        Logger().wtf("$e\n$s");
        if (e.statusCode == '422') {
          emit(SignUpFailureState(
            message: e.message,
          ));
        } else {
          emit(SignUpFailureState());
        }
      }
    });
  }
}
