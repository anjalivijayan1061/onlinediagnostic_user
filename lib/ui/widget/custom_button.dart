import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;
  final double width, height;
  final IconData? iconData;
  final Function()? onPressed;
  const CustomButton({
    Key? key,
    required this.label,
    this.color = Colors.blue,
    this.width = double.infinity,
    this.height = 50,
    this.filled = false,
    this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: filled ? color : null,
        border: Border.all(color: color),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: filled ? Colors.white : color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: iconData != null ? 10 : 0,
              ),
              iconData != null
                  ? Icon(
                      iconData,
                      color: filled ? Colors.white : color,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
