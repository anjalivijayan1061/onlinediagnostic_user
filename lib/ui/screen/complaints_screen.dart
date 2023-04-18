import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/complaint/complaint_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/complaints/add_complaint_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/complaints/complaint_card.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  ComplaintBloc complaintBloc = ComplaintBloc();

  @override
  void initState() {
    complaintBloc.add(GetAllComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintBloc>.value(
      value: complaintBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Complaints",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: BlocConsumer<ComplaintBloc, ComplaintState>(
            listener: (context, state) {
              if (state is ComplaintFailureState) {
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
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: state is ComplaintLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: state is ComplaintSuccessState
                                ? state.complaints.isNotEmpty
                                    ? Wrap(
                                        runSpacing: 15,
                                        children: List<Widget>.generate(
                                          state.complaints.length,
                                          (index) => ComplaintCard(
                                            complaintDetails:
                                                state.complaints[index],
                                            complaintBloc: complaintBloc,
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'No complaints found!',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                : state is ComplaintFailureState
                                    ? Center(
                                        child: CustomIconButton(
                                          icon: Icons.refresh_outlined,
                                          iconColor: Colors.blue,
                                          onTap: () {
                                            complaintBloc
                                                .add(GetAllComplaintEvent());
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
