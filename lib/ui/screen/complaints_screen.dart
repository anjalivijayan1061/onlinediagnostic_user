import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/complaints/add_complaint_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/complaints/complaint_card.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

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
        title: Text(
          "Complaints",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                  builder: (context) => const AddComplaintDialog(),
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
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ComplaintCard(),
          ),
        ],
      ),
    );
  }
}
