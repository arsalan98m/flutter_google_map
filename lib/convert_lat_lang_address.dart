import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLngAddress extends StatefulWidget {
  ConvertLatLngAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLngAddress> createState() => _ConvertLatLngAddressState();
}

class _ConvertLatLngAddressState extends State<ConvertLatLngAddress> {
  String stLngLat = "";
  String stAddress = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");

                List<Placemark> placemarks =
                    await placemarkFromCoordinates(24.9324, 67.0873);

                print(placemarks);

                setState(() {
                  stLngLat =
                      "${locations.last.longitude} ${locations.last.latitude}";

                  stAddress =
                      "${placemarks.reversed.last.street}, ${placemarks.reversed.last.locality}, ${placemarks.reversed.last.country}";
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text(
                      "Convert",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(stLngLat),
            Text(stAddress),
          ],
        ),
      ),
    );
  }
}
