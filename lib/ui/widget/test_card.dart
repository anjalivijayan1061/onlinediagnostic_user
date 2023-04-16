import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlinediagnostic_user/ui/screen/test_details_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:url_launcher/url_launcher.dart';

class TestBookingCard extends StatelessWidget {
  final Map<String, dynamic> testBookingDetails;

  const TestBookingCard({
    Key? key,
    required this.testBookingDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black26,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${testBookingDetails['id']}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    testBookingDetails['status'],
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: testBookingDetails['status'].toLowerCase() ==
                                  'accepted'
                              ? Colors.green
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LabelWithText(
                    label: 'Memeber Name',
                    text: testBookingDetails['patient']['name'],
                  ),
                  LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Date',
                    text: DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(testBookingDetails['created_at'])),
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              ...List<Widget>.generate(
                testBookingDetails['test_booking_items'].length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Material(
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              testBookingDetails['test_booking_items'][index]
                                  ['test']['name'],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          Text(
                            testBookingDetails['test_booking_items'][index]
                                ['status'],
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
                    ),
                  ),
                ),
              ),
              testBookingDetails['test_booking_items'].length > 3
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${testBookingDetails['test_booking_items'].length - 3} more test ',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                    )
                  : const SizedBox(),
              testBookingDetails['payment_status'] == 'paid'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total-550',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 15, color: Colors.red[600])),
                    )
                  : const SizedBox(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment:
                      testBookingDetails['prescription_document'] != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                  children: [
                    testBookingDetails['prescription_document'] != null
                        ? GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  testBookingDetails['prescription_document']));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  color: Colors.blue[400],
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'View Document',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TestDetailsScreen(
                              testDetails: testBookingDetails,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                      ),
                      child: const Text('Details'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
