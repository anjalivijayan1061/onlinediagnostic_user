import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_user/blocs/suggestion/suggestion_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class AddSuggestionDialog extends StatefulWidget {
  const AddSuggestionDialog({
    super.key,
  });

  @override
  State<AddSuggestionDialog> createState() => _AddSuggestionDialogState();
}

class _AddSuggestionDialogState extends State<AddSuggestionDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController suggestionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                controller: suggestionController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter a suggestion';
                  }
                },
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton(
                      label: 'Send',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SuggestionBloc>(context).add(
                            AddSuggestionEvent(
                              suggestion: suggestionController.text.trim(),
                            ),
                          );

                          Navigator.pop(context);
                        }
                      },
                      filled: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
