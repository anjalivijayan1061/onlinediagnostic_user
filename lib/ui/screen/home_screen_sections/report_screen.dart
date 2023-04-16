import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/orders/orders_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';

import '../../widget/test_card.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) async {
          if (state is OrdersFailureState) {
            await showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: "Failure",
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
            BlocProvider.of<OrdersBloc>(context)
                .add(GetOrdersEvent(status: 'complete'));
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: state is OrdersSuccessState
                    ? state.orders.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => TestBookingCard(
                              testBookingDetails: state.orders[index],
                            ),
                            itemCount: state.orders.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          )
                        : const Center(
                            child: Text('No Completed Tests'),
                          )
                    : state is OrdersLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );
  }
}
