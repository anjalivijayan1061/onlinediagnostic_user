import 'package:flutter/material.dart';

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
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
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
              children: const [
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Today',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.red[800],
                ),
                const Text(
                  '  you have successfully',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(
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
                const Text(
                  '  Sample collected successfully',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Previous',
              style: TextStyle(fontSize: 30, color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
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
          const SizedBox(
            height: 80,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
