import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          "Notifications",
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                Text(
                  'You have ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '2 notifications',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Text(
                  ' today',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Today',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.red[800],
                ),
                Text(
                  '  you have successfully changed your phone number',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.red[800],
                ),
                Text(
                  '  Sample collected successfully',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Previous',
              style: TextStyle(fontSize: 30, color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.black26,
                ),
                Text('  test request is on process',
                    style: TextStyle(fontSize: 18, color: Colors.black38)),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Divider(),
        ],
      ),
    );
  }
}
