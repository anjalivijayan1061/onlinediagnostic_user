import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/complaints/complaint_card.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/suggestions/add_suggestion_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/suggestions/suggestion_card.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({super.key});

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
          "Suggestion",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddSuggestionDialog(),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SuggestionCard(),
          ),
        ],
      ),
    );
  }
}
