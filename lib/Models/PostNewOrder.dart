class PostNewOrder {
  String shippingAddress;
  String customerId;
  String product;
  int quantity;
  double totalCost;
  double productCost;

  PostNewOrder(
      {this.shippingAddress,
        this.customerId,
        this.product,
        this.quantity,
        this.totalCost,
        this.productCost});

  PostNewOrder.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'];
    customerId = json['customerId'];
    product = json['product'];
    quantity = json['quantity'];
    totalCost = json['totalCost'];
    productCost = json['productCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shippingAddress'] = this.shippingAddress;
    data['customerId'] = this.customerId;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['totalCost'] = this.totalCost;
    data['productCost'] = this.productCost;
    return data;
  }
}