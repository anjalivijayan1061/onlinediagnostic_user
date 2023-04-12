import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';

class TestInfoCard extends StatelessWidget {
  final Map<String, dynamic> testDetails;
  final Function() onDelete;
  final Function(Map<String, dynamic>)? onSelect;
  final bool isReadOnly;
  const TestInfoCard({
    super.key,
    required this.testDetails,
    required this.onDelete,
    this.onSelect,
    this.isReadOnly = false,
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
      child: InkWell(
        onTap: isReadOnly ? () => onSelect!(testDetails) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      testDetails['name'],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  isReadOnly
                      ? const SizedBox()
                      : CustomIconButton(
                          icon: Icons.delete_forever,
                          iconColor: Colors.red,
                          onTap: () {
                            onDelete();
                          },
                        ),
                ],
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
                      text: '₹ ${testDetails['price'].toString()}',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Duration',
                      text: '${testDetails['duration'].toString()} Hour',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Sample Type',
                text: testDetails['sample_type'],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Can collect sample from home : ',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                    children: [
                      TextSpan(
                        text: testDetails['sample_from_home'] ? 'Yes' : 'No',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: testDetails['sample_from_home']
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
      ),
    );
  }
}
