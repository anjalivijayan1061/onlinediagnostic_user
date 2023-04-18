import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:onlinediagnostic_user/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/test_selector.dart';

class AddComplaintDialog extends StatefulWidget {
  final int testBookingId;
  const AddComplaintDialog({
    super.key,
    required this.testBookingId,
  });

  @override
  State<AddComplaintDialog> createState() => _AddComplaintDialogState();
}

class _AddComplaintDialogState extends State<AddComplaintDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController complaintController = TextEditingController();

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
                controller: complaintController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter a complaint';
                  }
                },
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
                          BlocProvider.of<ComplaintBloc>(context).add(
                            AddComplaintEvent(
                              complaint: complaintController.text.trim(),
                              testBookingId: widget.testBookingId,
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
