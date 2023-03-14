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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomCard(
            title: 'Haemoglobin',
            sample: "Sample-Blood",
            collectedfrom: "Collected From-Home",
            rs: "Rs-500",
            status: "Pending",
          ),
          CustomCard(
            title: 'Haemoglobin',
            sample: "Sample-Blood",
            collectedfrom: "Collected From-Home",
            rs: "Rs-500",
            status: "Testing",
          ),
          CustomCard(
            title: 'Haemoglobin',
            sample: "Sample-Blood",
            collectedfrom: "Collected From-Home",
            rs: "Rs-500",
            status: "Done",
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
  final String title, sample, collectedfrom, rs, status;
  const CustomCard({
    Key? key,
    required this.title,
    required this.sample,
    required this.collectedfrom,
    required this.rs,
    required this.status,
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
                      Row(
                        children: [
                          Text(title),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            status,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(sample),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(collectedfrom),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(rs),
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
