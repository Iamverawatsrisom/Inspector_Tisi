import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:pasadu/models/marker_model.dart';
import 'package:pasadu/screens/my_stye.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pasadu/screens/normal_dialog.dart';

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
  LocationData currenLocationData;
  LatLng currenLatLng;
  CameraPosition cameraPosition;

  String _descripPic, _dateTime, _time;

  final formkey = GlobalKey<FormState>();

  // Methode
  @override
  void initState() {
    super.initState();
    currentMarkerModel = widget.markerModel;
    findLatLng();
  }

  Future<void> findLatLng() async {
    currenLocationData = await locationData();
    print('Lat =====> ${currenLocationData.latitude}');
    print('Lng =====> ${currenLocationData.longitude}');

    setState(() {
      currenLatLng =
          LatLng(currenLocationData.latitude, currenLocationData.longitude);
    });
  }

  Future<LocationData> locationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {}
  }

  Widget showMapLocation() {
    if (currenLatLng != null) {
      cameraPosition = CameraPosition(
        target: currenLatLng,
        zoom: 16.0,
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
        markers: myMarker(),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          position: currenLatLng,
          markerId: MarkerId('idUser'),
          infoWindow: InfoWindow(
            title: currentMarkerModel.traderName,
            snippet: '${currenLatLng.latitude},${currenLatLng.longitude}',
          ))
    ].toSet();
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
    DateTime dateTime = DateTime.now();
    _dateTime = DateFormat('dd/MM/yy').format(dateTime);
    return Text(
      'Date = $_dateTime',
      style: MyStyle().h3TextStyle,
    );
  }

  Widget showTime() {
    DateTime dateTime = DateTime.now();
    _time = DateFormat('HH:mm').format(dateTime);
    return Text(
      'Time = $_time',
      style: MyStyle().h3TextStyle,
    );
  }

  Widget descripImage() {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: Colors.black12,
      ),
      child: Form(
        key: formkey,
        child: TextFormField(
          onSaved: (String string) {
            _descripPic = string.trim();
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.photo),
            hintText: 'ใส่รายละเอียดรูปภาพ :',
          ),
        ),
      ),
    );
  }

  Widget confirmButton() {
    return RaisedButton(
      color: MyStyle().textColorEmphasize,
      child: Text('Confirm Data', style: TextStyle(color: MyStyle().textColor)),
      onPressed: () {
        formkey.currentState.save();

        if (file == null) {
          normalDialog(context, 'คุณยังไม่ได้เลือกรูป', 'กรุณาเลือกรูปภาพ');
        } else if (_descripPic.isEmpty) {
          normalDialog(context, 'รายละเอียดรูป', 'กรุณาใส่รายละเอียด');
        } else {
          myAlerDialog();
        }
      },
    );
  }

  Widget showTitle() {
    return ListTile(
      leading: Icon(
        Icons.add_box,
        size: 36.0,
        color: MyStyle().textColor,
      ),
      title: Text(
        'โปรดยืนยัน',
        style: MyStyle().h3TextStyle,
      ),
    );
  }

  Widget showDialogImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        ),
      ),
      height: 150.0, width: 280.0,
      // child: Image.file(file),
    );
  }

  Widget showContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showTraderName(),
        showDialogImage(),
        showText('::   $_descripPic'),
        showText('lat = ${currenLatLng.latitude}'),
        showText('lng = ${currenLatLng.longitude}'),
      ],
    );
  }

  Widget saveComfirmButton() {
    return FlatButton(
      child: Text('save'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget cancelComfirmButton() {
    return FlatButton(
      child: Text('cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showText(String string) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(width: 230.0,
          child: Text(
            string,
            style: MyStyle().h3TextStyle,
          ),
        ),
      ],
    );
  }

  Future<void> myAlerDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: showTitle(),
            content: showContent(),
            actions: <Widget>[
              saveComfirmButton(),
              cancelComfirmButton(),
            ],
          );
        });
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
          mySizeBox(),
          descripImage(),
          mySizeBox(),
          showButton(),
          mySizeBox(),
          showMapLocation(),
          mySizeBox(),
          showDate(),
          mySizeBox(),
          showTime(),
          mySizeBox(),
          confirmButton(),
        ],
      ),
    );
  }
}
