import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlinediagnostic_user/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_user/ui/screen/membercreation_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_map.dart';
import 'package:onlinediagnostic_user/ui/widget/label_with_text.dart';
import 'package:onlinediagnostic_user/util/get_age.dart';

class MemberCard extends StatefulWidget {
  final Map<String, dynamic> patientDetails;
  final PatientBloc patientBloc;
  final bool isReadOnly;
  final Function(Map<String, dynamic>)? onCallback;
  const MemberCard({
    Key? key,
    required this.patientDetails,
    required this.patientBloc,
    this.isReadOnly = false,
    this.onCallback,
  }) : super(key: key);

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.isReadOnly
            ? () => widget.onCallback!(widget.patientDetails)
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.patientDetails['name'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  widget.isReadOnly
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomIconButton(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MembercreationScreen(
                                      patientDetails: widget.patientDetails,
                                    ),
                                  ),
                                );

                                widget.patientBloc.add(GetAllPatientEvent());
                              },
                              icon: Icons.edit,
                              iconColor: Colors.blue,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            CustomIconButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => CustomAlertDialog(
                                    title: 'Are you sure?',
                                    message:
                                        'Are you sure you want to delete this member? any data associated with this member will be deleted as well',
                                    primaryButtonLabel: 'Delete',
                                    primaryOnPressed: () {
                                      widget.patientBloc.add(
                                        DeletePatientEvent(
                                          patientId:
                                              widget.patientDetails['id'],
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                    secondaryButtonLabel: 'Cancel',
                                  ),
                                );
                              },
                              icon: Icons.delete_forever,
                              iconColor: Colors.red,
                            ),
                          ],
                        ),
                ],
              ),
              const Divider(),
              LabelWithText(
                label: 'Address',
                text: widget.patientDetails['address'],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Age',
                      text: getAge(
                        DateTime.parse(
                          widget.patientDetails['dob'],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Gender',
                      text: widget.patientDetails['gender'],
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
                      label: 'Phone',
                      text: widget.patientDetails['phone'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'City',
                      text: widget.patientDetails['city'],
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
                      label: 'District',
                      text: widget.patientDetails['district'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'State',
                      text: widget.patientDetails['state'],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: widget.isReadOnly ? 0 : 10,
              ),
              widget.isReadOnly
                  ? const SizedBox()
                  : CustomButton(
                      height: 40,
                      label: 'Location',
                      onPressed: () {
                        LatLng latLng = LatLng(
                          widget.patientDetails['latitude'],
                          widget.patientDetails['longitude'],
                        );

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CustomMap(
                              latLng: latLng,
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
