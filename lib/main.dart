import 'package:flutter/material.dart';
import 'package:flutter_google_maps/user_current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserCurrentLocation(),
    );
  }
}
