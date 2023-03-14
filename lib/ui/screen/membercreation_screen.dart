import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';

enum Gender { male, female, others }

class MembercreationScreen extends StatefulWidget {
  const MembercreationScreen({super.key});

  @override
  State<MembercreationScreen> createState() => _MembercreationScreenState();
}

class _MembercreationScreenState extends State<MembercreationScreen> {
  Gender? _character = Gender.male;
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
            "Member Creation",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(labelText: "Name -"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(labelText: "Age -"),
                ),
              ),
              CustomButton(label: 'Location'),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Gender",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.black54,
                                    ),
                          ),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Gender.male,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                            Text(
                              "Male",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Gender.female,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                            Text(
                              "Female",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Gender.others,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                            Text(
                              "Others",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(labelText: "Email ID-"),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 150,
                      child: CustomButton(
                        label: "Continue",
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
