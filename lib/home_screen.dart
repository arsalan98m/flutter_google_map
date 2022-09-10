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

  final Set<Marker> markers = {};

  List<LatLng> points = [
    LatLng(24.9141617, 67.082216),
    LatLng(24.932152, 67.086014),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < points.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://images.bitmoji.com/3d/avatar/201714142-99447061956_1-s5-v1.webp');

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetWidth: 300,
        targetHeight: 300,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();

      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: points[i],
          infoWindow: const InfoWindow(
            title: 'Really cool place',
            snippet: '5 star rating',
          ),
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
        ),
      );
    }

    setState(() {});
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;

    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
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
            ),
          ],
        ),
      ),
    );
  }
}
