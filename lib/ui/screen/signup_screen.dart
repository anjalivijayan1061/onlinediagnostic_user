import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_user/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:onlinediagnostic_user/ui/screen/home_screen_sections/home_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Signup Failed',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                  primaryOnPressed: () => Navigator.pop(context),
                ),
              );
            } else if (state is SignUpSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => true,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1582719471384-894fbb16e074?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Material(
                  color: Colors.black38,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Enter your phone number, email and password to continue ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.trim().isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter password';
                                }
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
                              label: 'Signup',
                              filled: true,
                              isLoading: state is SignUpLoadingState,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String email = emailController.text.trim();
                                  String password =
                                      passwordController.text.trim();
                                  String phone =
                                      phoneNumberController.text.trim();
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpEvent(
                                      email: email,
                                      password: password,
                                      phone: phone,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Text(
                                'By signing up you agree to our terms and conditions and privacy policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
