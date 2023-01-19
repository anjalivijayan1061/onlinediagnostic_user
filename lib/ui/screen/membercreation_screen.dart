import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/newtest_screen.dart';

class MembercreationScreen extends StatelessWidget {
  const MembercreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Member Creation",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(),
              ),
              TextField(
                decoration: InputDecoration(),
              ),
              CustomButton(label: 'Location'),
              CustomButton(label: 'Gender', color: Colors.black),
              TextField(
                decoration: InputDecoration(),
              ),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                ),
              ),
            ],
          ),
        ));
  }
}
