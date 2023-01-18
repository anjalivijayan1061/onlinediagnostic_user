import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/screen/signin_screen.dart';
import 'package:onlinediagnostic_user/ui/screen/verifyotp_screen.dart';
import 'package:onlinediagnostic_user/ui/screen/home_screen.dart';
import 'package:onlinediagnostic_user/ui/screen/teststatus_screen.dart';
import 'package:onlinediagnostic_user/ui/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TeststatusScreen(),
    );
  }
}
