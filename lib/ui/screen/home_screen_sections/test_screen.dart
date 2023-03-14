import 'package:flutter/material.dart';

import '../../widget/test_card.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hi Person,",
              style: TextStyle(fontSize: 23),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView(
              children: const [
                TestCard(
                  date: '12/12/1212',
                  status: 'Pending',
                ),
                TestCard(
                  date: '12/12/1212',
                  status: 'Pending',
                ),
                TestCard(
                  date: '12/12/1212',
                  status: 'Pending',
                ),
                TestCard(
                  date: '12/12/1212',
                  status: 'Pending',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
