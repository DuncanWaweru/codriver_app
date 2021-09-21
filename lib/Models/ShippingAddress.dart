class ShippingAddress {
  String customerId;
  String region;
  String physicalAddress;

  ShippingAddress({this.customerId, this.region, this.physicalAddress});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    region = json['region'];
    physicalAddress = json['physicalAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['region'] = this.region;
    data['physicalAddress'] = this.physicalAddress;
    return data;
  }
}
