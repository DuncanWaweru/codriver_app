class MyAppointments {
  String siteVisitAppointmentId;
  String visitCode;
  String customerId;
  Customer customer;
  String dealersId;
  Dealers dealers;
  String visitDate;
  String productId;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  MyAppointments(
      {this.siteVisitAppointmentId,
        this.visitCode,
        this.customerId,
        this.customer,
        this.dealersId,
        this.dealers,
        this.visitDate,
        this.productId,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  MyAppointments.fromJson(Map<String, dynamic> json) {
    siteVisitAppointmentId = json['siteVisitAppointmentId'];
    visitCode = json['visitCode'];
    customerId = json['customerId'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    dealersId = json['dealersId'];
    dealers =
    json['dealers'] != null ? new Dealers.fromJson(json['dealers']) : null;
    visitDate = json['visitDate'];
    productId = json['productId'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteVisitAppointmentId'] = this.siteVisitAppointmentId;
    data['visitCode'] = this.visitCode;
    data['customerId'] = this.customerId;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['dealersId'] = this.dealersId;
    if (this.dealers != null) {
      data['dealers'] = this.dealers.toJson();
    }
    data['visitDate'] = this.visitDate;
    data['productId'] = this.productId;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}

class Customer {
  String customerId;
  String name;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  Customer(
      {this.customerId,
        this.name,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    name = json['name'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['name'] = this.name;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}

class Dealers {
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

  Dealers(
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

  Dealers.fromJson(Map<String, dynamic> json) {
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