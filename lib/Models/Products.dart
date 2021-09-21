class Products {
  final String productType;
  final String size;
  final String productName;
  final String wholeSalePrice;
  final String retailPrice;
  final String active;
  final String dealersId;

  Products(this.productType, this.size,this.productName,this.wholeSalePrice,this.retailPrice,this.active,this.dealersId);

  Products.fromJson(Map<String, dynamic> json)
      : productType = json['productType'],
        size = json['size'],
        productName = json['productName'],
        wholeSalePrice = json['wholeSalePrice'],
        retailPrice = json['retailPrice'],
        dealersId = json['dealersId'],
        active = json['active'];

  Map<String, dynamic> toJson() =>
      {
        'productType': productType,
        'size': size,
        'productName': productName,
        'wholeSalePrice': wholeSalePrice,
        'retailPrice': retailPrice,
        'dealersId': dealersId,
        'active': active,
      };
}
