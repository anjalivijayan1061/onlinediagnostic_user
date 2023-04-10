import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_all_tests_event.dart';
part 'get_all_tests_state.dart';

class GetAllTestsBloc extends Bloc<GetAllTestsEvent, GetAllTestsState> {
  GetAllTestsBloc() : super(GetAllTestsInitialState()) {
    on<GetAllTestsEvent>((event, emit) async {
      emit(GetAllTestsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('tests');
      try {
        List<dynamic> temp = event.testId != null
            ? await queryTable
                .select()
                .ilike('id', '%${event.testId}%')
                .single()
            : await queryTable.select().order('id', ascending: false);

        List<Map<String, dynamic>> tests =
            temp.map((e) => e as Map<String, dynamic>).toList();

        emit(
          GetAllTestsSuccessState(tests: tests),
        );
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(GetAllTestsFailureState(message: e.toString()));
      }
    });
  }
}
