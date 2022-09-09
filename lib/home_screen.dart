import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImage;

  List images = ['assets/car.png', 'assets/car.png', 'assets/car.png'];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9141617, 67.082216),
    zoom: 14.4746,
  );

  List<Marker> markers = [];

  final List<LatLng> latLng = [
    LatLng(24.9141617, 67.082216),
    LatLng(24.9368, 67.0760),
    LatLng(24.932152, 67.086014)
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // *** Generating Car Icon *** //
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);

    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadData() async {
    for (int i = 0; i <= latLng.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 50);

      markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: latLng[i],
          infoWindow: InfoWindow(title: 'This is title marker $i'),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );

      setState(() {});
    }
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
    );
  }
}
