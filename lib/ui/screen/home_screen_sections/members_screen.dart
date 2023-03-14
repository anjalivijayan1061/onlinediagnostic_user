import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/membercreation_screen.dart';
import 'package:onlinediagnostic_user/ui/screen/newtest_screen.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CustomCard(
          title: 'John',
        ),
        const CustomCard(
          title: 'Rani',
        ),
        const CustomCard(
          title: 'Lena',
        ),
        const CustomCard(
          title: 'Roshan',
        ),
        const CustomCard(
          title: 'Joseph',
        ),
        CustomButton(
          label: 'New Member',
          iconData: Icons.add,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MembercreationScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  const CustomCard({
    Key? key,
    required this.title,
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
                      Text(title),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("32"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Male"),
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
