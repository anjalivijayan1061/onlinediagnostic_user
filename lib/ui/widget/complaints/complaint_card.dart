import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:onlinediagnostic_user/util/get_date.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintDetails;
  final ComplaintBloc complaintBloc;
  const ComplaintCard({
    super.key,
    required this.complaintDetails,
    required this.complaintBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDate(DateTime.parse(
                      complaintDetails['complaint']['created_at'])),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                CustomIconButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Are you sure',
                        message:
                            'Are you sure you want to delete this complaint? This action cannot be undone',
                        primaryButtonLabel: 'Delete',
                        primaryOnPressed: () {
                          complaintBloc.add(
                            DeleteComplaintEvent(
                              complaintId: complaintDetails['complaint']['id'],
                            ),
                          );

                          Navigator.pop(context);
                        },
                        secondaryButtonLabel: 'Cancel',
                        secondaryOnPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                  icon: Icons.delete_forever_outlined,
                  iconColor: Colors.red,
                ),
              ],
            ),
            const Divider(
              color: Colors.black38,
            ),
            Text(
              complaintDetails['complaint']['complaint'],
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const Divider(
              color: Colors.black38,
            ),
            CustomButton(
              height: 45,
              label: 'Test Details',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaintDetails['test']['name'],
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: LabelWithText(
                                label: 'Price',
                                text:
                                    '₹ ${complaintDetails['test']['price'].toString()}',
                              ),
                            ),
                            Expanded(
                              child: LabelWithText(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                label: 'Duration',
                                text:
                                    '${complaintDetails['test']['duration'].toString()} Hour',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelWithText(
                          label: 'Sample Type',
                          text: complaintDetails['test']['sample_type'],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Can collect sample from home : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                              children: [
                                TextSpan(
                                  text: complaintDetails['test']
                                          ['sample_from_home']
                                      ? 'Yes'
                                      : 'No',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: complaintDetails['test']
                                                ['sample_from_home']
                                            ? Colors.green[700]
                                            : Colors.red[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
