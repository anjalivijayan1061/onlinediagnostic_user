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
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const [
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
