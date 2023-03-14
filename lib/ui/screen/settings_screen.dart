import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_user/ui/screen/newtest_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Settings",
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search for a setting.... ",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print('tap');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print('tap');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print('tap');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('Complaints'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print('tap');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.light_mode_sharp),
              title: Text('Suggestion'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                print('tap');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
