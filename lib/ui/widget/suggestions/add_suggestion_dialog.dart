import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class AddSuggestionDialog extends StatelessWidget {
  const AddSuggestionDialog({
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
              "Send your suggestion",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "What could be improved ?",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 3,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: "Suggestion",
                prefixIcon: Icon(
                  Icons.comment,
                ),
              ),
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
