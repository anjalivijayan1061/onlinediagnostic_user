import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final Color iconColor;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: iconColor.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
