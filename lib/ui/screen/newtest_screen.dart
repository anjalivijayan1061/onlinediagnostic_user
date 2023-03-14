import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/teststatus_screen.dart';

class NewtestScreen extends StatelessWidget {
  const NewtestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            const Icon(
              Icons.arrow_back,
              color: Colors.black26,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "New Test Request",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
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
            CustomCards(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
            ),
            CustomCards(
              title: 'Haemoglobin',
              sample: "Sample-Blood",
              collectedfrom: "Collected From-Home",
              rs: "Rs-500",
            ),
            CustomCards(
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

class CustomCards extends StatelessWidget {
  final String title, sample, collectedfrom, rs;
  const CustomCards({
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

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;
  final double size;
  final IconData? iconData;
  final Function()? onPressed;
  const CustomButton({
    Key? key,
    required this.label,
    this.color = Colors.blue,
    this.size = double.infinity,
    this.filled = false,
    this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: size,
        height: 50,
        decoration: BoxDecoration(
          color: filled ? color : null,
          border: Border.all(color: color),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: iconData != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: filled ? Colors.white : color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                iconData != null
                    ? Icon(
                        iconData,
                        color: filled ? Colors.white : color,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
