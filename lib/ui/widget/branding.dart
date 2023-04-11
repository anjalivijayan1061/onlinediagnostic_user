import 'package:flutter/material.dart';

class Branding extends StatelessWidget {
  const Branding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.biotech,
          color: Colors.white,
          size: 100,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Online Diagnostics',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
