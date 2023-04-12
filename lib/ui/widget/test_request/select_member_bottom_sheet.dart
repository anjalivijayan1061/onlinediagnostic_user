import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/member/member_card.dart';

class SelectMemberBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onPressed;
  const SelectMemberBottomSheet({
    super.key,
    required this.onPressed,
  });

  @override
  State<SelectMemberBottomSheet> createState() =>
      _SelectMemberBottomSheetState();
}

class _SelectMemberBottomSheetState extends State<SelectMemberBottomSheet> {
  PatientBloc patientBloc = PatientBloc();

  @override
  void initState() {
    patientBloc.add(GetAllPatientEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientBloc>.value(
      value: patientBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a member for test request.',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<PatientBloc, PatientState>(
              listener: (context, state) {
                if (state is PatientFailureState) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Failed!',
                      message: state.message,
                      primaryButtonLabel: 'Ok',
                    ),
                  );
                }
              },
              builder: (context, state) {
                return state is PatientLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: state is PatientSuccessState
                            ? state.patients.isNotEmpty
                                ? SingleChildScrollView(
                                    child: Wrap(
                                      runSpacing: 10,
                                      children: List<Widget>.generate(
                                        state.patients.length,
                                        (index) => MemberCard(
                                          patientDetails: state.patients[index],
                                          patientBloc: patientBloc,
                                          isReadOnly: true,
                                          onCallback: (map) {
                                            widget.onPressed(map);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No members found!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: Colors.black54,
                                          ),
                                    ),
                                  )
                            : state is PatientFailureState
                                ? Center(
                                    child: CustomIconButton(
                                      onTap: () {
                                        patientBloc.add(GetAllPatientEvent());
                                      },
                                      icon: Icons.refresh,
                                      iconColor: Colors.blue,
                                    ),
                                  )
                                : const SizedBox(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
