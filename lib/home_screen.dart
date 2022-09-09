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
  Set<Polygon> polygon = HashSet<Polygon>();

  List<LatLng> points = [
    LatLng(24.9141617, 67.082216),
    LatLng(24.932152, 67.086014),
    LatLng(24.9368, 67.0760),
    LatLng(24.9141617, 67.082216),
  ];

  @override
  void initState() {
    super.initState();

    polygon.add(Polygon(
      polygonId: PolygonId('1'),
      points: points,
      fillColor: Colors.red.withOpacity(0.3),
      geodesic: true,
      strokeWidth: 4,
    ));
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
              polygons: polygon,
            ),
          ],
        ),
      ),
    );
  }
}
