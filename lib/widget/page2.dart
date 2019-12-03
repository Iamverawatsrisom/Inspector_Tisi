import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
   //field
  static const LatLng startLatLng = const LatLng(13.765353, 100.527265);
  CameraPosition cameraPosition = CameraPosition(
    target: startLatLng,
    zoom: 16.0,
  );

  // Method
  Widget showMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController){},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMap();
  }
}