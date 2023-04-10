import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/test_selector.dart';

class AddComplaintDialog extends StatelessWidget {
  const AddComplaintDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Send your complaint",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 3,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: "Complaint",
                prefixIcon: Icon(
                  Icons.warning,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TestSelector(
              onSelect: (testId) {
                Logger().wtf(testId.toString());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Cancel',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Send',
                    onPressed: () {},
                    filled: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
