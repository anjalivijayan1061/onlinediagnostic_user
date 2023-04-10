import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/get_all_tests/get_all_tests_bloc.dart';

import 'custom_alert_dialog.dart';

class TestSelector extends StatefulWidget {
  final Function(int) onSelect;
  final int selectedTest;
  const TestSelector({
    super.key,
    required this.onSelect,
    this.selectedTest = 0,
  });

  @override
  State<TestSelector> createState() => _TestSelectorState();
}

class _TestSelectorState extends State<TestSelector> {
  final GetAllTestsBloc testBloc = GetAllTestsBloc();
  int? selectedText;
  @override
  void initState() {
    testBloc.add(GetAllTestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetAllTestsBloc>.value(
      value: testBloc,
      child: BlocConsumer<GetAllTestsBloc, GetAllTestsState>(
        listener: (context, state) {
          if (state is GetAllTestsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed!',
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  testBloc.add(GetAllTestsEvent());
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetAllTestsSuccessState) {
            return Material(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                color: Colors.grey,
              )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: DropdownButton(
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: Text(
                    'Select Test',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  value: selectedText,
                  onChanged: (value) {
                    widget.onSelect(value);
                    selectedText = value;
                    setState(() {});
                  },
                  items: List<DropdownMenuItem>.generate(
                    state.tests.length,
                    (index) => DropdownMenuItem(
                      value: state.tests[index]['id'],
                      child: Text(
                        state.tests[index]['name'],
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is GetAllTestsFailureState) {
            return const SizedBox();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
