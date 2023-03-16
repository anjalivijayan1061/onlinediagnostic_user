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
              label: 'Select',
            ),
            CustomCard1(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
              testduration: "Test Duration- 1 hr",
            ),
            CustomCard1(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
              testduration: "Test Duration- 1 hr",
            ),
            CustomCard1(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
              testduration: "Test Duration- 1 hr",
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

class CustomCard1 extends StatelessWidget {
  final String title, sample, collectedfrom, rs, testduration;
  const CustomCard1({
    Key? key,
    required this.title,
    required this.sample,
    required this.collectedfrom,
    required this.rs,
    required this.testduration,
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
                          Text(
                            collectedfrom,
                            textAlign: TextAlign.end,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(rs),
                          ),
                        ],
                      ),
                      Text(testduration)
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
