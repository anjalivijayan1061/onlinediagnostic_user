import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_action_button.dart';
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
  Map<String, dynamic> memeberMap = {};
  List<Map<String, dynamic>> testsList = [];
  PlatformFile? pickedFile;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            onTap: memeberMap.isNotEmpty
                                ? () {}
                                : () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            SelectMemberBottomSheet(
                                              onPressed: (map) {
                                                memeberMap = map;
                                                setState(() {});
                                              },
                                            ));
                                  },
                            isSelected: memeberMap.isNotEmpty,
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
                                builder: (context) => SelectTestBottomSheet(
                                  onPressed: (map) {
                                    testsList.add(map);
                                    setState(() {});
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
                            memeberMap.isNotEmpty
                                ? CustomIconButton(
                                    icon: Icons.delete_forever,
                                    iconColor: Colors.red,
                                    onTap: () {
                                      memeberMap.clear();
                                      setState(() {});
                                    },
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        memeberMap.isNotEmpty
                            ? MemberTestCard(
                                memberDetails: memeberMap,
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
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
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
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: memeberMap.isNotEmpty &&
                        testsList.isNotEmpty &&
                        pickedFile != null
                    ? CustomButton(
                        label: 'Send Request',
                        onPressed: () {},
                        filled: true,
                      )
                    : const SizedBox(),
              ),
            ),
          ],
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
