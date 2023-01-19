import 'package:flutter/material.dart';

class TeststatusScreen extends StatelessWidget {
  const TeststatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "10/03/2023",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CustomCard(
            title: 'Haemoglobin',
          ),
          CustomCard(
            title: 'Haemoglobin',
          ),
          CustomCard(
            title: 'Haemoglobin',
          ),
          ElevatedButton(
            child: const Text('Pay Now'),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sample-Blood"),
                      ),
                      Row(
                        children: [
                          Text("Collected From-Home"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Rs-500"),
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
