class MyProducts {
  String productId;
  String productType;
  String productCode;
  double size;
  String productName;
  double wholeSalePrice;
  double retailPrice;
  bool active;
  String dealersId;
  List<ProductImage> productImage;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  MyProducts(
      {this.productId,
        this.productType,
        this.productCode,
        this.size,
        this.productName,
        this.wholeSalePrice,
        this.retailPrice,
        this.active,
        this.dealersId,
        this.productImage,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  MyProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productType = json['productType'];
    productCode = json['productCode'];
    size = json['size'];
    productName = json['productName'];
    wholeSalePrice = json['wholeSalePrice'];
    retailPrice = json['retailPrice'];
    active = json['active'];
    dealersId = json['dealersId'];
    if (json['productImage'] != null) {
      productImage = new List<ProductImage>();
      json['productImage'].forEach((v) {
        productImage.add(new ProductImage.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productType'] = this.productType;
    data['productCode'] = this.productCode;
    data['size'] = this.size;
    data['productName'] = this.productName;
    data['wholeSalePrice'] = this.wholeSalePrice;
    data['retailPrice'] = this.retailPrice;
    data['active'] = this.active;
    data['dealersId'] = this.dealersId;
    if (this.productImage != null) {
      data['productImage'] = this.productImage.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}

class ProductImage {
  String productImageId;
  String imageFile;
  String productId;
  String createdOn;
  Null createdBy;
  String updatedOn;
  Null updateddBy;

  ProductImage(
      {this.productImageId,
        this.imageFile,
        this.productId,
        this.createdOn,
        this.createdBy,
        this.updatedOn,
        this.updateddBy});

  ProductImage.fromJson(Map<String, dynamic> json) {
    productImageId = json['productImageId'];
    imageFile = json['imageFile'];
    productId = json['productId'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updateddBy = json['updateddBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productImageId'] = this.productImageId;
    data['imageFile'] = this.imageFile;
    data['productId'] = this.productId;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['updatedOn'] = this.updatedOn;
    data['updateddBy'] = this.updateddBy;
    return data;
  }
}