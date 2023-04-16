import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState()) {
    on<OrdersEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder queryTable = supabaseClient.from('test_bookings');
        if (event is GetOrdersEvent) {
          List<dynamic> tempOrders = await supabaseClient.rpc(
            'get_test_bookings',
            params: {
              'search_status': event.status,
              'search_user_id': supabaseClient.auth.currentUser!.id,
              'search_patient_id': event.patientId,
            },
          );

          List<Map<String, dynamic>> orders =
              tempOrders.map((e) => e as Map<String, dynamic>).toList();

          Logger().w(orders);

          emit(OrdersSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          Map<String, dynamic> data = {
            'user_id': supabaseClient.auth.currentUser!.id,
            'patient_id': event.patientId,
          };

          if (event.prescription != null) {
            String path = await supabaseClient.storage.from('docs').upload(
                'prescriptions/${DateTime.now().millisecondsSinceEpoch.toString()}${event.prescription!.name}',
                File(event.prescription!.path!));

            path = path.replaceRange(0, 5, '');

            Logger().wtf(path);

            data['prescription_document'] =
                supabaseClient.storage.from('docs').getPublicUrl(path);
          }

          Map<String, dynamic> order =
              await queryTable.insert(data).select().single();

          if (event.tests.isNotEmpty) {
            List<Map<String, dynamic>> orderItems = [];
            for (int i = 0; i < event.tests.length; i++) {
              orderItems.add(
                {
                  'test_booking_id': order['id'],
                  'test_id': event.tests[i]['id'],
                  'price': event.tests[i]['price'],
                },
              );
            }
            await supabaseClient.from('test_booking_item').insert(orderItems);
          }

          add(GetOrdersEvent());
        } else if (event is DeleteOrderEvent) {
          await queryTable.delete().eq('id', event.orderId);
          add(GetOrdersEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrdersFailureState());
      }
    });
  }
}
