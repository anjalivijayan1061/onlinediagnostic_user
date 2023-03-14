import 'package:flutter/material.dart';
import 'package:onlinediagnostic_user/ui/widget/profile_picture_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePictureItem(
            image: "assets/images/person.png",
            onTap: () {},
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Name ",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Address -",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Age -",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Gender -",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Phone no -",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Email Id-",
                prefixIcon: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
