import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlinediagnostic_user/ui/widget/map_location_selector.dart';

class CustomActionButton extends StatefulWidget {
  final String label;
  final Function() onTap;
  final IconData icon;
  final bool isSelected;
  const CustomActionButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon = Icons.add,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        focusColor: Colors.grey[50],
        hoverColor: Colors.grey[50],
        highlightColor: Colors.grey[50],
        splashColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              widget.isSelected
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
