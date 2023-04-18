import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:onlinediagnostic_user/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_user/blocs/orders/orders_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:onlinediagnostic_user/util/create_order.dart';
import 'package:onlinediagnostic_user/util/get_age.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/complaints/add_complaint_dialog.dart';

class TestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> testDetails;
  final OrdersBloc ordersBloc;
  const TestDetailsScreen(
      {super.key, required this.testDetails, required this.ordersBloc});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  final Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        title: 'Payment Success',
        message: 'Thank you for the payment. Reopen the page to see changes',
        primaryButtonLabel: 'Ok',
      ),
    );

    widget.ordersBloc.add(
      PaymentOrderEvent(
        orderId: widget.testDetails['id'],
        paymentId: response.paymentId ?? '',
      ),
    );

    Navigator.of(context).pop();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Logger().e(response.error);
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Payment Failed',
        message: response.message ?? 'Something went wrong, Please try again',
        primaryButtonLabel: 'Ok',
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment() async {
    // String orderId = await createOrder(widget.testDetails['total_price']);

    var options = {
      'key': 'rzp_test_j07YpjyCexi5xr',
      'amount': widget.testDetails['total_price'] * 100,
      'name': 'Online Diagnostics',
      // 'order_id': orderId,
      'description': '#${widget.testDetails['id']}',
      'prefill': {
        'contact': '7012874004',
        'email': Supabase.instance.client.auth.currentUser!.email,
      }
    };
    Logger().w(options);
    _razorpay.open(options);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black54),
        title: Text(
          '#${widget.testDetails['id']}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Center(
            child: Text(
              widget.testDetails['status'],
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider<ComplaintBloc>.value(
                  value: ComplaintBloc(),
                  child: AddComplaintDialog(
                    testBookingId: widget.testDetails['id'],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.report_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Member Name',
                      text: widget.testDetails['patient']['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Age & Gender',
                      text:
                          '${getAge(DateTime.parse(widget.testDetails['patient']['dob']))} ${widget.testDetails['patient']['gender']}',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Total Price',
                      text: '₹${widget.testDetails['total_price'].toString()}',
                    ),
                  ),
                  widget.testDetails['can_pay']
                      ? widget.testDetails['payment_status'] == 'pending'
                          ? TextButton(
                              onPressed: () {
                                makePayment();
                              },
                              child: const Text(
                                'Make Payment',
                              ),
                            )
                          : Text(
                              'Paid',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.green,
                                  ),
                            )
                      : const SizedBox(),
                ],
              ),
              const Divider(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Total Tests',
                      text: widget.testDetails['test_booking_items'].length
                          .toString(),
                    ),
                  ),
                  widget.testDetails['prescription_document'] != null
                      ? TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                widget.testDetails['prescription_document']));
                          },
                          child: const Text('View Document'),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) => Material(
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.testDetails['test_booking_items']
                                      [index]['test']['name'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                              LabelWithText(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                label: 'Sample type',
                                text: widget.testDetails['test_booking_items']
                                    [index]['test']['sample_type'],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelWithText(
                                label: 'Duration',
                                text:
                                    '${widget.testDetails['test_booking_items'][index]['test']['duration']}hrs',
                              ),
                              const SizedBox(height: 5),
                              LabelWithText(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                label: 'Price',
                                text:
                                    '₹${widget.testDetails['test_booking_items'][index]['test']['price']}',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelWithText(
                                label: 'Sample from home',
                                text: widget.testDetails['test_booking_items']
                                        [index]['test']['sample_from_home']
                                    ? 'Yes'
                                    : 'No',
                              ),
                              widget.testDetails['test_booking_items'][index]
                                          ['report'] !=
                                      null
                                  ? TextButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(widget.testDetails[
                                                'test_booking_items'][index]
                                            ['report']));
                                      },
                                      child: const Text('View Report'),
                                    )
                                  : Text(
                                      widget.testDetails['test_booking_items']
                                          [index]['status'],
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: widget.testDetails['test_booking_items'].length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
