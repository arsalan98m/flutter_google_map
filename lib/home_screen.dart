import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Polygon ka faida kya hai, Polygon ko jo use hai woh yeh hai k for example ap kisi ek specific area k andar operate kar rahy hain for example hum ny jo red area draw kia hai gulshan sy lucky one or water pump tak ka usmy operate kar rahy hain so jo bhi apka user is area sy bahar hai ap usko login na karny dain uski location agar issy match nhi karti tu login na karny dain these are the applications of plygon

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9141617, 67.082216),
    zoom: 14.4746,
  );

  final Set<Marker> markers = {};
  Set<Polyline> polyline = {};

  List<LatLng> points = [
    LatLng(24.9141617, 67.082216),
    LatLng(24.932152, 67.086014),
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < points.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: points[i],
          infoWindow: const InfoWindow(
            title: 'Really cool place',
            snippet: '5 star rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }

    polyline.add(
      Polyline(
        polylineId: const PolylineId("1"),
        points: points,
        color: Colors.green,
        width: 4,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: ((GoogleMapController controller) {
                _controller.complete(controller);
              }),
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              markers: markers,
              polylines: polyline,
            ),
          ],
        ),
      ),
    );
  }
}
