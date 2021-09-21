class CustomerShippingAddress {
  String customerId;
  String name;
  IdentityUser identityUser;
  List<ShippingAddress> shippingAddress;
  String createdOn;
  String updatedOn;

  CustomerShippingAddress(
      {this.customerId,
        this.name,
        this.identityUser,
        this.shippingAddress,
        this.createdOn,
        this.updatedOn});

  CustomerShippingAddress.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    name = json['name'];
    identityUser = json['identityUser'] != null
        ? new IdentityUser.fromJson(json['identityUser'])
        : null;
    if (json['shippingAddress'] != null) {
      shippingAddress = new List<ShippingAddress>();
      json['shippingAddress'].forEach((v) {
        shippingAddress.add(new ShippingAddress.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['name'] = this.name;
    if (this.identityUser != null) {
      data['identityUser'] = this.identityUser.toJson();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] =
          this.shippingAddress.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}

class IdentityUser {
  String userName;
  String normalizedUserName;
  String email;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  bool lockoutEnabled;
  int accessFailedCount;

  IdentityUser(
      {this.userName,
        this.normalizedUserName,
        this.email,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnabled,
        this.accessFailedCount});

  IdentityUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnabled = json['lockoutEnabled'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnabled'] = this.lockoutEnabled;
    data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }
}

class ShippingAddress {
  String shippingAddressId;
  String customerId;
  String region;
  String physicalAddress;
  String createdOn;
  String updatedOn;

  ShippingAddress(
      {this.shippingAddressId,
        this.customerId,
        this.region,
        this.physicalAddress,
        this.createdOn,
        this.updatedOn});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    shippingAddressId = json['shippingAddressId'];
    customerId = json['customerId'];
    region = json['region'];
    physicalAddress = json['physicalAddress'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shippingAddressId'] = this.shippingAddressId;
    data['customerId'] = this.customerId;
    data['region'] = this.region;
    data['physicalAddress'] = this.physicalAddress;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}