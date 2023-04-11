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

class MemberCard extends StatelessWidget {
  final Map<String, dynamic> patientDetails;
  final PatientBloc patientBloc;
  const MemberCard({
    Key? key,
    required this.patientDetails,
    required this.patientBloc,
  }) : super(key: key);

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
                    patientDetails['name'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MembercreationScreen(
                              patientDetails: patientDetails,
                            ),
                          ),
                        );

                        patientBloc.add(GetAllPatientEvent());
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
                              patientBloc.add(
                                DeletePatientEvent(
                                  patientId: patientDetails['id'],
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
              text: patientDetails['address'],
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
                        patientDetails['dob'],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Gender',
                    text: patientDetails['gender'],
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
                    text: patientDetails['phone'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'City',
                    text: patientDetails['city'],
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
                    text: patientDetails['district'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'State',
                    text: patientDetails['state'],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              height: 40,
              label: 'Location',
              onPressed: () {
                LatLng latLng = LatLng(
                  patientDetails['latitude'],
                  patientDetails['longitude'],
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
    );
  }
}
