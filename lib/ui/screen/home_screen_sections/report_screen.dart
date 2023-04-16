import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/test_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      children: const [
        TestBookingCard(
          testBookingDetails: {},
        ),
      ],
    );
  }
}
