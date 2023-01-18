import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    body:
    Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Center(
                  child: Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ))),
          Text(
            "Sign In",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter your phone number to continue",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.amber[600],
          ),
          Text(
            "By signing in you agree to our terms and conditions and private policy",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
