import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  //field
  static const LatLng startLatLng = const LatLng(13.765353, 100.527265);
  CameraPosition cameraPosition = CameraPosition(
    target: startLatLng,
    zoom: 16.0,
  );

  double lat = 13.765353, lng = 100.527265;

  // Method
  Set<Marker> mySet() {
    LatLng firstlatLng = LatLng(lat, lng);
    Marker firstMarker = Marker(
      position: firstlatLng,
      markerId: MarkerId('First'),
      infoWindow: InfoWindow(
        title: 'สนง.มาตรฐานผลิตภัณฑ์อุตสาหกรรม',
        snippet: 'Tisi',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(230.0),
    );
    return <Marker>[
      firstMarker,
    ].toSet();
  }

  Widget showMap() {
    return GoogleMap(
      markers: mySet(),
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMap();
  }
}
