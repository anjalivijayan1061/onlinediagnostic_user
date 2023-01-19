import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Members",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CustomCard(
            title: 'John',
          ),
          CustomCard(
            title: 'Rani',
          ),
          CustomCard(
            title: 'Lena',
          ),
          CustomCard(
            title: 'Roshan',
          ),
          CustomCard(
            title: 'Joseph',
          ),
          ElevatedButton(
            child: const Text('+  New Member'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[400],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  const CustomCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black26,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(title),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("32"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Male"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
