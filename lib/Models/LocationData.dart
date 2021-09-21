class LocationData {
  double latitude;
  double longitude;
  String dealerId;

  LocationData({this.latitude, this.longitude,this.dealerId});

  LocationData.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    dealerId = json['dealerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dealerId'] = this.dealerId;
    return data;
  }
}