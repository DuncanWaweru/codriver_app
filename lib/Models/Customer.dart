class Customer {
  String customerId;
  String name;
  IdentityUser identityUser;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  Customer(
      {this.customerId,
        this.name,
        this.identityUser,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    name = json['name'];
    identityUser = json['identityUser'] != null
        ? new IdentityUser.fromJson(json['identityUser'])
        : null;
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['name'] = this.name;
    if (this.identityUser != null) {
      data['identityUser'] = this.identityUser.toJson();
    }
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}

class IdentityUser {
  String email;
  bool emailConfirmed;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  bool lockoutEnabled;

  IdentityUser(
      {this.email,
        this.emailConfirmed,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnabled});

  IdentityUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    twoFactorEnabled = json['twoFactorEnabled'];
    lockoutEnabled = json['lockoutEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['emailConfirmed'] = this.emailConfirmed;
    data['phoneNumber'] = this.phoneNumber;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['lockoutEnabled'] = this.lockoutEnabled;
    return data;
  }
}