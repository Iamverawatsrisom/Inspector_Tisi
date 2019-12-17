import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pasadu/models/marker_model.dart';
import 'package:pasadu/screens/my_stye.dart';
import 'package:image_picker/image_picker.dart';

class DetailJob extends StatefulWidget {
  final MarkerModel markerModel;
  DetailJob({Key key, this.markerModel}) : super(key: key);
  @override
  _DetailJobState createState() => _DetailJobState();
}

class _DetailJobState extends State<DetailJob> {
  // Explicit
  MarkerModel currentMarkerModel;
  File file;

  // Methode
  @override
  void initState() {
    super.initState();
    currentMarkerModel = widget.markerModel;
  }

  Widget showMapLocation() {
    LatLng latLng = LatLng(13.766333, 100.526707);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  Widget cameraButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: MyStyle().textColor,
      icon: Icon(
        Icons.add_a_photo,
        color: Colors.white,
      ),
      label: Text(
        'Camera',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        cameraOrGallery(ImageSource.camera);
      },
    );
  }

  Future<void> cameraOrGallery(ImageSource imageSource) async {
    var object = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 800.0, maxHeight: 600.0);

    setState(() {
      file = object;
    });
  }

  Widget galleryButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: MyStyle().mainColor,
      icon: Icon(
        Icons.add_photo_alternate,
        color: Colors.white,
      ),
      label: Text(
        'gallery',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        cameraOrGallery(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[cameraButton(), galleryButton()],
    );
  }

  Widget showPic() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      height: 5.0,
    );
  }

  Widget showTraderName() {
    return Text(
      currentMarkerModel.traderName,
      style: MyStyle().h2TextStyle,
    );
  }

  Widget showType() {
    return Text(
      currentMarkerModel.type,
      style: MyStyle().h3TextStyle,
    );
  }

  Widget showAddress() {
    return Text(currentMarkerModel.address);
  }

  Widget showDate() {
    return Text('dd/mm/yyyy');
  }

  Widget showTime() {
    return Text('hh:mm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          showTraderName(),
          mySizeBox(),
          showType(),
          mySizeBox(),
          showAddress(),
          showPic(),
          showButton(),
          mySizeBox(),
          showMapLocation(),
        ],
      ),
    );
  }
}
