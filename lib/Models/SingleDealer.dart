class SingleDealer {
  String dealersId;
  String dealerCode;
  String dealerName;
  String address;
  String mobileNo;
  String emailAddress;
  double latitude;
  double longitude;
  bool active;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  SingleDealer(
      {this.dealersId,
        this.dealerCode,
        this.dealerName,
        this.address,
        this.mobileNo,
        this.emailAddress,
        this.latitude,
        this.longitude,
        this.active,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  SingleDealer.fromJson(Map<String, dynamic> json) {
    dealersId = json['dealersId'];
    dealerCode = json['dealerCode'];
    dealerName = json['dealerName'];
    address = json['address'];
    mobileNo = json['mobileNo'];
    emailAddress = json['emailAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    active = json['active'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealersId'] = this.dealersId;
    data['dealerCode'] = this.dealerCode;
    data['dealerName'] = this.dealerName;
    data['address'] = this.address;
    data['mobileNo'] = this.mobileNo;
    data['emailAddress'] = this.emailAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['active'] = this.active;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}