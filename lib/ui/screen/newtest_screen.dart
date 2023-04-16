import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/orders/orders_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_action_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_file_picker.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:onlinediagnostic_user/ui/widget/test_request/select_member_bottom_sheet.dart';
import 'package:onlinediagnostic_user/ui/widget/test_request/select_test_bottom_sheet.dart';
import 'package:onlinediagnostic_user/ui/widget/test_request/test_info_card.dart';
import 'package:onlinediagnostic_user/util/get_age.dart';

class NewtestScreen extends StatefulWidget {
  const NewtestScreen({super.key});

  @override
  State<NewtestScreen> createState() => _NewtestScreenState();
}

class _NewtestScreenState extends State<NewtestScreen> {
  Map<String, dynamic>? memeberMap;
  List<Map<String, dynamic>> testsList = [];
  PlatformFile? pickedFile;

  String getTotal() {
    if (pickedFile != null) {
      return 'Cannot Determine';
    } else if (testsList.isNotEmpty) {
      int price = 0;

      for (int i = 0; i < testsList.length; i++) {
        price += int.parse(testsList[i]['price'].toString());
      }

      return price.toString();
    } else {
      return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "New Test Request",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          getTotal(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (memeberMap != null) {
                        if (testsList.isNotEmpty || pickedFile != null) {
                          BlocProvider.of<OrdersBloc>(context).add(
                            AddOrderEvent(
                              patientId: memeberMap!['id'],
                              tests: testsList,
                              prescription: pickedFile,
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const CustomAlertDialog(
                              title: 'Tests Required',
                              message:
                                  'Select tests or upload a prescription document to continue.',
                              primaryButtonLabel: 'Ok',
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Select Member',
                            message: 'Select a mamber to book tests.',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    },
                    child: const Text('Continue'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a member, select tests and upload patient document to send a new test request.',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomActionButton(
                        label: 'Member',
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (context) => SelectMemberBottomSheet(
                                    onPressed: (map) {
                                      memeberMap = map;
                                      setState(() {});
                                    },
                                  ));
                        },
                        isSelected: memeberMap != null,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: CustomActionButton(
                        label: 'Add Tests',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (context) => SelectTestBottomSheet(
                              onPressed: (map) {
                                if (testsList
                                    .where(
                                        (element) => element['id'] == map['id'])
                                    .isEmpty) {
                                  testsList.add(map);
                                  setState(() {});
                                }
                              },
                            ),
                          );
                        },
                        isSelected: testsList.isNotEmpty,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomActionButton(
                  label: 'Upload Document',
                  icon: Icons.upload_rounded,
                  onTap: () async {
                    PlatformFile? file = await pickFile();
                    if (file != null) {
                      pickedFile = file;
                      setState(() {});
                    }
                  },
                  isSelected: pickedFile != null,
                ),
                const Divider(
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Member info',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
                        ),
                        memeberMap != null
                            ? CustomIconButton(
                                icon: Icons.delete_forever,
                                iconColor: Colors.red,
                                onTap: () {
                                  memeberMap = null;
                                  setState(() {});
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    memeberMap != null
                        ? MemberTestCard(
                            memberDetails: memeberMap!,
                          )
                        : Text(
                            'Empty',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                    const Divider(
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tests info',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: testsList.isNotEmpty
                          ? Wrap(
                              runSpacing: 10,
                              children: List<Widget>.generate(
                                testsList.length,
                                (index) => TestInfoCard(
                                  testDetails: testsList[index],
                                  onDelete: () {
                                    testsList.removeAt(index);
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                          : Text(
                              'Empty',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MemberTestCard extends StatelessWidget {
  final Map<String, dynamic> memberDetails;
  const MemberTestCard({
    super.key,
    required this.memberDetails,
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
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Name',
                    text: memberDetails['name'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Age',
                    text: getAge(DateTime.parse(memberDetails['dob'])),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Gender',
                    text: memberDetails['gender'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Phone',
                    text: memberDetails['phone'].toString(),
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
