import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/home_screen_sections/home_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/test_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TestCard(
              date: '12/03/2022',
              status: 'Completed',
              isPaid: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TestCard(
              date: '12/04/2022',
              status: 'Completed',
              isPaid: false,
            ),
          ),
        ],
      ),
    );
  }
}
