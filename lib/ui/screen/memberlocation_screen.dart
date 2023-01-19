import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/screen/newtest_screen.dart';

class MemberlocationScreen extends StatelessWidget {
  const MemberlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Member Location",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Place",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "City",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Pin",
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select your live location -'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
