import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_user/ui/screen/membercreation_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/member/member_card.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
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
      child: BlocConsumer<PatientBloc, PatientState>(
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
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 80,
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: state is PatientLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: state is PatientSuccessState
                            ? state.patients.isNotEmpty
                                ? Wrap(
                                    runSpacing: 15,
                                    children: List<Widget>.generate(
                                      state.patients.length,
                                      (index) => MemberCard(
                                        patientDetails: state.patients[index],
                                        patientBloc: patientBloc,
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      'No members found!\nClick on New Member button to create a new member',
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                            : state is PatientFailureState
                                ? Center(
                                    child: CustomIconButton(
                                      icon: Icons.refresh_outlined,
                                      iconColor: Colors.blue,
                                      onTap: () {
                                        patientBloc.add(GetAllPatientEvent());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: CustomButton(
                    filled: true,
                    label: 'New Member',
                    iconData: Icons.add,
                    onPressed: state is PatientLoadingState
                        ? () {}
                        : () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MembercreationScreen(),
                              ),
                            );

                            patientBloc.add(GetAllPatientEvent());
                          },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
