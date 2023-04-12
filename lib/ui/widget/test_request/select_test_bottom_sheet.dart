import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/get_all_tests/get_all_tests_bloc.dart';
import 'package:onlinediagnostic_user/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/test_request/test_info_card.dart';

class SelectTestBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onPressed;
  const SelectTestBottomSheet({
    super.key,
    required this.onPressed,
  });

  @override
  State<SelectTestBottomSheet> createState() => _SelectTestBottomSheetState();
}

class _SelectTestBottomSheetState extends State<SelectTestBottomSheet> {
  GetAllTestsBloc getAllTestBloc = GetAllTestsBloc();

  @override
  void initState() {
    getAllTestBloc.add(GetAllTestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetAllTestsBloc>.value(
      value: getAllTestBloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a test for new test request.',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<GetAllTestsBloc, GetAllTestsState>(
              listener: (context, state) {
                if (state is GetAllTestsFailureState) {
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
                return state is GetAllTestsLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: state is GetAllTestsSuccessState
                            ? state.tests.isNotEmpty
                                ? SingleChildScrollView(
                                    child: Wrap(
                                      runSpacing: 10,
                                      children: List<Widget>.generate(
                                        state.tests.length,
                                        (index) => TestInfoCard(
                                          testDetails: state.tests[index],
                                          isReadOnly: true,
                                          onSelect: (map) {
                                            widget.onPressed(map);
                                            Navigator.pop(context);
                                          },
                                          onDelete: () {},
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
                                        getAllTestBloc.add(GetAllTestsEvent());
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
