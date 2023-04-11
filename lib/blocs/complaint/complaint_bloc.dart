import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitialState()) {
    on<ComplaintEvent>((event, emit) async {
      emit(ComplaintLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('complaints');
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('tests');
      List<Map<String, dynamic>> complaintWithTestList = [];
      try {
        if (event is GetAllComplaintEvent) {
          List<dynamic> temp = await queryTable
              .select()
              .eq('user_id', supabaseClient.auth.currentUser!.id)
              .order(
                'created_at',
              );

          List<Map<String, dynamic>> complaints =
              temp.map((e) => e as Map<String, dynamic>).toList();

          Map<String, dynamic> complaintWithTestMap = {};

          for (Map<String, dynamic> complaint in complaints) {
            Map<String, dynamic> test = await subQueryTable
                .select()
                .eq('id', complaint['test_id'])
                .single();

            complaintWithTestMap = {
              'complaint': complaint,
              'test': test,
            };

            complaintWithTestList.add(complaintWithTestMap);
          }
          emit(
            ComplaintSuccessState(
              complaints: complaintWithTestList,
            ),
          );
        } else if (event is AddComplaintEvent) {
          await queryTable.insert(
            {
              'user_id': supabaseClient.auth.currentUser!.id,
              'test_id': event.testId,
              'complaint': event.complaint,
            },
          );

          add(GetAllComplaintEvent());
        } else if (event is DeleteComplaintEvent) {
          await queryTable.delete().eq('id', event.complaintId);
          add(GetAllComplaintEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ComplaintFailureState());
      }
    });
  }
}
