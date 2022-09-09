import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9141617, 67.082216),
    zoom: 14.4746,
  );

  List<Marker> _markers = [];

  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.9141617, 67.082216),
      infoWindow: InfoWindow(title: 'My Position'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.9368, 67.0760),
      infoWindow: InfoWindow(title: 'Water Pump'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(24.9324, 67.0873),
      infoWindow: InfoWindow(title: 'Lucky one mall'),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(24.9449517288, 67.0855423611),
      infoWindow: InfoWindow(title: 'Sohrab Goth Bus Stop'),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(33.9391, 67.7100),
      infoWindow: InfoWindow(title: 'Afghanistan'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _markers.addAll(_list);
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
          markers: Set<Marker>.of(_markers),
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(33.9391, 67.7100),
                zoom: 14,
              ),
            ),
          );
          // setState(() {});
        },
        child: const Icon(
          Icons.location_disabled_outlined,
        ),
      ),
    );
  }
}
