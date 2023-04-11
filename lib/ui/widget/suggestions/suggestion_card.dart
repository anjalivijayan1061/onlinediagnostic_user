import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/blocs/suggestion/suggestion_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/util/get_date.dart';

class SuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestionDetails;
  final SuggestionBloc suggestionBloc;
  const SuggestionCard({
    super.key,
    required this.suggestionDetails,
    required this.suggestionBloc,
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
                  getDate(DateTime.parse(suggestionDetails['created_at'])),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                CustomIconButton(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Are you sure',
                      message:
                          'Are you sure you want to delete this complaint? This action cannot be undone',
                      primaryButtonLabel: 'Delete',
                      primaryOnPressed: () {
                        suggestionBloc.add(
                          DeleteSuggestionEvent(
                            suggestionId: suggestionDetails['id'],
                          ),
                        );

                        Navigator.pop(context);
                      },
                      secondaryButtonLabel: 'Cancel',
                      secondaryOnPressed: () => Navigator.pop(context),
                    ),
                  ),
                  icon: Icons.delete_forever_outlined,
                  iconColor: Colors.red,
                ),
              ],
            ),
            const Divider(
              color: Colors.black38,
            ),
            Text(
              suggestionDetails['suggestion'],
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
