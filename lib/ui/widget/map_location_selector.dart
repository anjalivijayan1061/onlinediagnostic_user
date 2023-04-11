import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlinediagnostic_user/blocs/util/location_bloc/location_service_bloc.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_alert_dialog.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_button.dart';
import 'package:onlinediagnostic_user/ui/widget/custom_icon_button.dart';

class MapLocationSelector extends StatefulWidget {
  const MapLocationSelector({Key? key}) : super(key: key);

  @override
  State<MapLocationSelector> createState() => MapLocationSelectorState();
}

class MapLocationSelectorState extends State<MapLocationSelector> {
  GoogleMapController? _controller;
  LocationServiceBloc locationServiceBloc = LocationServiceBloc();
  Position? locationData;

  static const CameraPosition _behrainCamera = CameraPosition(
    target: LatLng(11.876710293022969, 75.37148588331785),
    zoom: 12,
  );

  Set<Marker> _selectedLocationMarker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LocationServiceBloc>.value(
        value: locationServiceBloc,
        child: BlocConsumer<LocationServiceBloc, LocationServiceState>(
          listener: (context, state) async {
            if (state is LocationServiceGrantedState) {
              locationData = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );
              if (locationData != null) {
                _controller!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        locationData!.latitude,
                        locationData!.longitude,
                      ),
                      zoom: 19,
                    ),
                  ),
                );
              }
            } else if (state is LocationServiceAskState) {
              locationServiceBloc.add(LocationServiceAskEvent());
            } else if (state is LocationServiceDeniedForeverState) {
              await showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'No Permission',
                  message:
                      'Please provide location permission to get current location',
                  primaryButtonLabel: 'Open App Settings',
                  primaryOnPressed: () async {
                    await Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is LocationServiceDisabledState) {
              await showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Location Disabled',
                  message:
                      'You\'ve disabled the location services of this device. Please open the location settings and enable location services',
                  primaryButtonLabel: 'Open Location Settings',
                  primaryOnPressed: () async {
                    await Geolocator.openLocationSettings();
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.hybrid,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _behrainCamera,
                  markers: _selectedLocationMarker,
                  onTap: (tappedLoc) {
                    _selectedLocationMarker = {
                      Marker(
                        markerId: const MarkerId('location'),
                        position: tappedLoc,
                      ),
                    };
                    setState(() {});
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    setState(() {});
                  },
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                _controller != null
                    ? SafeArea(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // CustomIconButton(
                                //   onTap: () async {
                                //     String _apiKey =
                                //         'AIzaSyBTEiarE0hH1DM5bMgsHy-0N3Wxps32c7A';
                                //     places.Prediction? place =
                                //         await PlacesAutocomplete.show(
                                //       context: context,
                                //       apiKey: _apiKey,
                                //       mode: Mode.overlay, // Mode.fullscreen
                                //       language: "en",
                                //       components: [],
                                //       types: [],
                                //       strictbounds: false,
                                //     );

                                //     if (place != null) {
                                //       places.GoogleMapsPlaces _googleMapsPlaces =
                                //           places.GoogleMapsPlaces(
                                //         apiKey: _apiKey,
                                //         apiHeaders: await const GoogleApiHeaders()
                                //             .getHeaders(),
                                //       );
                                //       places.PlacesDetailsResponse placeDetails =
                                //           await _googleMapsPlaces
                                //               .getDetailsByPlaceId(place.placeId!);

                                //       _controller!.animateCamera(
                                //         CameraUpdate.newCameraPosition(
                                //           CameraPosition(
                                //             target: LatLng(
                                //               placeDetails
                                //                   .result.geometry!.location.lat,
                                //               placeDetails
                                //                   .result.geometry!.location.lng,
                                //             ),
                                //             zoom: 19,
                                //           ),
                                //         ),
                                //       );
                                //       _selectedLocationMarker = {
                                //         Marker(
                                //           markerId: const MarkerId('location'),
                                //           position: LatLng(
                                //             placeDetails
                                //                 .result.geometry!.location.lat,
                                //             placeDetails
                                //                 .result.geometry!.location.lng,
                                //           ),
                                //         ),
                                //       };
                                //       setState(() {});
                                //     }
                                //   },
                                //   icon: const Icon(
                                //     Icons.search_rounded,
                                //     color: primaryButtonColor,
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomIconButton(
                                  onTap: () {
                                    locationServiceBloc
                                        .add(LocationServiceAskEvent());
                                  },
                                  icon: Icons.my_location_rounded,
                                  iconColor: Colors.blue[800]!,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _selectedLocationMarker.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: CustomButton(
                mainAxisSize: MainAxisSize.min,
                label: 'Continue',
                iconData: Icons.arrow_forward_ios_outlined,
                filled: true,
                onPressed: () {
                  Navigator.pop(
                      context, _selectedLocationMarker.first.position);
                },
              ),
            )
          : const SizedBox(),
    );
  }
}
