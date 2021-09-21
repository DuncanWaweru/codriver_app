class SiteVisitAppointment {
  String customerId;
  String dealerId;
  String visitDate;
  String productId;

  SiteVisitAppointment(
      {this.customerId, this.dealerId, this.visitDate, this.productId});

  SiteVisitAppointment.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    dealerId = json['dealerId'];
    visitDate = json['visitDate'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['dealerId'] = this.dealerId;
    data['visitDate'] = this.visitDate;
    data['productId'] = this.productId;
    return data;
  }
}