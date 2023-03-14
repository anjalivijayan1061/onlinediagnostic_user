import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/home_screen.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black26,
              ),
            ),
            Text(
              "Reports",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TestCard(
                date: '12/03/2022',
                status: 'Completed',
                isActive: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TestCard(
                date: '12/04/2022',
                status: 'Completed',
                isActive: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
