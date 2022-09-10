import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

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

  String mapTheme = '';

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  loadAssets() async {
    final value = await DefaultAssetBundle.of(context)
        .loadString('assets/silver_theme.json');

    mapTheme = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: ((GoogleMapController controller) {
                controller.setMapStyle(mapTheme);
                _controller.complete(controller);
              }),
              initialCameraPosition: _kGooglePlex,
            ),
          ],
        ),
      ),
    );
  }
}
