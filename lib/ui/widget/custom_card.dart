import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title, sample, collectedfrom, rs;
  const CustomCard({
    Key? key,
    required this.title,
    required this.sample,
    required this.collectedfrom,
    required this.rs,
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
                          Icon(Icons.check_circle_outline),
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
