import 'package:flutter/material.dart';

class VerifyotpScreen extends StatelessWidget {
  const VerifyotpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (MediaQuery.of(context).size.height / 2) + 50,
            width: double.infinity,
            color: Colors.orange[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter your phone number to continue ',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
                const ElevatedButton(
                  onPressed: null,
                  child: Text('                   '),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      //onPrimary: Colors.black,
                    ),
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const Text(
                  'By signing in you agree to our terms  and conditions and privacy policy',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
