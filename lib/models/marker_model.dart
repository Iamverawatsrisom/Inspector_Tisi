class MarkerModel {
  String autoNo;
  String traderId;
  String traderName;
  String address;
  String type;
  String lat;
  String lng;
  String pathImage;
  String dateUpdate;
  String timeUpdate;
  String idCheck;

  MarkerModel(
      {this.autoNo,
      this.traderId,
      this.traderName,
      this.address,
      this.type,
      this.lat,
      this.lng,
      this.pathImage,
      this.dateUpdate,
      this.timeUpdate,
      this.idCheck});

  MarkerModel.fromJson(Map<String, dynamic> json) {
    autoNo = json['auto_no'];
    traderId = json['trader_id'];
    traderName = json['trader_name'];
    address = json['address'];
    type = json['type'];
    lat = json['lat'];
    lng = json['lng'];
    pathImage = json['path_image'];
    dateUpdate = json['date_update'];
    timeUpdate = json['time_update'];
    idCheck = json['idCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auto_no'] = this.autoNo;
    data['trader_id'] = this.traderId;
    data['trader_name'] = this.traderName;
    data['address'] = this.address;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['path_image'] = this.pathImage;
    data['date_update'] = this.dateUpdate;
    data['time_update'] = this.timeUpdate;
    data['idCheck'] = this.idCheck;
    return data;
  }
}
