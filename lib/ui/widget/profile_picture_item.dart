import 'package:flutter/material.dart';

class ProfilePictureItem extends StatelessWidget {
  final String image;
  final Function() onTap;
  const ProfilePictureItem({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  height: 90,
                  width: 90,
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            right: 0,
            bottom: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
