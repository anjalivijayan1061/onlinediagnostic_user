import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitial()) {
    on<ComplaintEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
