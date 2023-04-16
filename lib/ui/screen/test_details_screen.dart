import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:onlinediagnostic_user/util/get_age.dart';
import 'package:url_launcher/url_launcher.dart';

class TestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> testDetails;
  const TestDetailsScreen({super.key, required this.testDetails});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
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
          const SizedBox(width: 20),
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
                  widget.testDetails['can_pay'] &&
                          widget.testDetails['payment_status'] == 'pending'
                      ? TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Make Payment',
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
