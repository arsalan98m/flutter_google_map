import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesAPI extends StatefulWidget {
  GooglePlacesAPI({Key? key}) : super(key: key);

  @override
  State<GooglePlacesAPI> createState() => _GooglePlacesAPIState();
}

class _GooglePlacesAPIState extends State<GooglePlacesAPI> {
  TextEditingController controller = TextEditingController();
  var uuid = Uuid();
  String sessionToken = '123456';
  List<dynamic> placesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }

    getSuggesion(controller.text);
  }

  void getSuggesion(String input) async {
    String kPLACES_API_KEY = 'YOUR_API_KEY';
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body)['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Search Places API'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                decoration:
                    InputDecoration(hintText: 'Search Places with name'),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () async {
                          // *** Converting address to longitude and latitude *** //
                          List<Location> location = await locationFromAddress(
                              placesList[index]["description"]);

                          print(location.last.latitude);
                          print(location.last.longitude);
                        },
                        title: Text(
                          placesList[index]["description"],
                        ),
                      );
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
