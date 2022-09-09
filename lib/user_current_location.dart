import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9141617, 67.082216),
    zoom: 14.4746,
  );

  List<Marker> markers = <Marker>[];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error=> $error");
    });

    return await Geolocator.getCurrentPosition();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(title: "My Current Location"),
      ));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: ((GoogleMapController controller) {
            _controller.complete(controller);
          }),
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          loadData();
        },
        child: const Icon(
          Icons.location_searching,
        ),
      ),
    );
  }
}
