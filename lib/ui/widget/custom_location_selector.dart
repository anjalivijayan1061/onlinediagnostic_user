import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlinediagnostic_user/ui/widget/map_location_selector.dart';

class CustomLocationSelector extends StatefulWidget {
  final String label;
  final Function(LatLng?) onSelect;
  const CustomLocationSelector({
    Key? key,
    required this.label,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CustomLocationSelector> createState() => _CustomLocationSelectorState();
}

class _CustomLocationSelectorState extends State<CustomLocationSelector> {
  LatLng? _selectedLocation;

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
        onTap: () async {
          LatLng? selectedLocation = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MapLocationSelector(),
            ),
          );

          if (selectedLocation != null) {
            _selectedLocation = selectedLocation;
            widget.onSelect(selectedLocation);
            setState(() {});
          }
        },
        focusColor: Colors.grey[50],
        hoverColor: Colors.grey[50],
        highlightColor: Colors.grey[50],
        splashColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  _selectedLocation != null
                      ? '${_selectedLocation!.latitude}\n${_selectedLocation!.longitude}'
                      : widget.label,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              _selectedLocation != null
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : const SizedBox(),
              SizedBox(
                width: _selectedLocation != null ? 6 : 0,
              ),
              _selectedLocation != null
                  ? GestureDetector(
                      onTap: () {
                        _selectedLocation = null;
                        widget.onSelect(_selectedLocation);
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
