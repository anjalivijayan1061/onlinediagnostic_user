import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/patient/patient_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_date_picker.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_location_selector.dart';
import 'package:onlinediagnostic_user/ui/widget/gender_selector.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MembercreationScreen extends StatefulWidget {
  final Map<String, dynamic>? patientDetails;
  const MembercreationScreen({super.key, this.patientDetails});

  @override
  State<MembercreationScreen> createState() => _MembercreationScreenState();
}

class _MembercreationScreenState extends State<MembercreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  DateTime? _dob;
  String _gender = 'male';
  LatLng? latitudeLongitude;

  @override
  void initState() {
    if (widget.patientDetails != null) {
      _nameController.text = widget.patientDetails!['name'];
      _addressController.text = widget.patientDetails!['address'];
      _phoneNumberController.text = widget.patientDetails!['phone'];
      _cityController.text = widget.patientDetails!['city'];
      _districtController.text = widget.patientDetails!['district'];
      _stateController.text = widget.patientDetails!['state'];
      _dob = DateTime.parse(widget.patientDetails!['dob']);
      _gender = widget.patientDetails!['gender'];
      latitudeLongitude = LatLng(widget.patientDetails!['latitude'],
          widget.patientDetails!['longitude']);
    }
    super.initState();
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
          widget.patientDetails != null ? 'Edit Member' : 'Add Member',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocProvider<PatientBloc>(
          create: (context) => PatientBloc(),
          child: BlocConsumer<PatientBloc, PatientState>(
            listener: (context, state) {
              if (state is PatientSuccessState) {
                Navigator.of(context).pop();
              } else if (state is PatientFailureState) {
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
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: state is PatientLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter Name';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: _addressController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter address';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Address',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value != null &&
                                  value.trim().isNotEmpty &&
                                  value.length == 10) {
                                return null;
                              } else {
                                return 'Please enter valid phone number';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Phone number',
                              prefixText: '+91 ',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _cityController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter your city';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'City',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _districtController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter your district';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'District',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _stateController,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter your state';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'State',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Gender',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          GenderSelector(
                            selected: _gender,
                            onSelect: (gender) {
                              _gender = gender;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Date of Birth',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomDatePicker(
                            defaultDate: _dob,
                            onPick: (date) {
                              _dob = date;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomLocationSelector(
                            label: latitudeLongitude != null
                                ? '${latitudeLongitude!.latitude.toString()}, ${latitudeLongitude!.longitude.toString()}'
                                : 'Select Location',
                            onSelect: (latLng) {
                              if (latLng != null) {
                                latitudeLongitude = latLng;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            filled: true,
                            label: widget.patientDetails != null
                                ? 'Save'
                                : 'Add Member',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_dob != null && latitudeLongitude != null) {
                                  if (widget.patientDetails != null) {
                                    BlocProvider.of<PatientBloc>(context).add(
                                      EditPatientEvent(
                                        patientId: widget.patientDetails!['id'],
                                        name: _nameController.text.trim(),
                                        phone:
                                            _phoneNumberController.text.trim(),
                                        address: _addressController.text.trim(),
                                        city: _cityController.text.trim(),
                                        district:
                                            _districtController.text.trim(),
                                        dob: _dob!,
                                        gender: _gender,
                                        state: _stateController.text.trim(),
                                        latitude: latitudeLongitude!.latitude,
                                        longitude: latitudeLongitude!.longitude,
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<PatientBloc>(context).add(
                                      AddPatientEvent(
                                        name: _nameController.text.trim(),
                                        phone:
                                            _phoneNumberController.text.trim(),
                                        address: _addressController.text.trim(),
                                        city: _cityController.text.trim(),
                                        district:
                                            _districtController.text.trim(),
                                        dob: _dob!,
                                        gender: _gender,
                                        state: _stateController.text.trim(),
                                        latitude: latitudeLongitude!.latitude,
                                        longitude: latitudeLongitude!.longitude,
                                      ),
                                    );
                                  }
                                } else if (_dob == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CustomAlertDialog(
                                      title: 'Required!',
                                      message:
                                          'Date of Birth is required, please select the Date of Birth',
                                      primaryButtonLabel: 'Ok',
                                    ),
                                  );
                                } else if (latitudeLongitude == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CustomAlertDialog(
                                      title: 'Required!',
                                      message:
                                          'Location is required, please select the location',
                                      primaryButtonLabel: 'Ok',
                                    ),
                                  );
                                } else {}
                              }
                            },
                            iconData: widget.patientDetails != null
                                ? Icons.save
                                : Icons.add,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
