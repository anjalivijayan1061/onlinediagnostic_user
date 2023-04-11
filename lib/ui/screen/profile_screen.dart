import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/profile/profile_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProfileBloc profileBloc = ProfileBloc();

  bool isObscure = true;

  @override
  void initState() {
    profileBloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider<ProfileBloc>.value(
        value: profileBloc,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              phoneNumberController.text = state.profileDetails['phone'];
              emailController.text = state.profileDetails['email'];
              passwordController.clear();
            } else if (state is ProfileFailureState) {
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
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: state is ProfileLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.trim().isNotEmpty &&
                                    value.length == 10) {
                                  return null;
                                } else {
                                  return 'Enter a valid phone number';
                                }
                              },
                              decoration: const InputDecoration(
                                prefixText: '+91 ',
                                labelText: "Phone",
                                prefixIcon: Icon(
                                  Icons.phone_android_outlined,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter email address';
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black87,
                              height: 30,
                            ),
                            Text(
                              "Please enter your password to update the profile details",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                return null;
                                // if (value!.trim().isNotEmpty) {
                                //   return null;
                                // } else {
                                //   return 'Enter password';
                                // }
                              },
                              obscureText: isObscure,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isObscure = !isObscure;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              label: 'Update',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  profileBloc.add(
                                    UpdateProfileEvent(
                                      email: emailController.text.trim(),
                                      phone: phoneNumberController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              filled: true,
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
