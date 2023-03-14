import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_card.dart';

class NewtestScreen extends StatelessWidget {
  const NewtestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "New Test Request",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Member',
              textAlign: TextAlign.start,
            ),
            CustomButton(
              label: 'Upload Document',
            ),
            CustomCard(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
            ),
            CustomCard(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
            ),
            CustomCard(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 5,
                    endIndent: 5,
                    height: 10,
                    color: Colors.black,
                  ),
                ),
                Text('OR'),
                Expanded(
                  child: Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            CustomButton(
              label: 'Upload Document',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total'),
                      Text(
                        'Rs-1500',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: const Text('Continue'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
