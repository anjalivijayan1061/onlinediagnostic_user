import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatelessWidget {
  final LatLng latLng;
  const CustomMap({Key? key, required this.latLng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Map View',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('location'),
            position: latLng,
          ),
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: CustomActionButton(
      //   mainAxisSize: MainAxisSize.min,
      //   label: 'Google Map',
      //   iconData: Icons.arrow_outward_outlined,
      //   onPressed: () {
      //     Uri uri = Uri.parse(
      //         'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}');

      //     canLaunchUrl(uri);
      //   },
      // ),
    );
  }
}
