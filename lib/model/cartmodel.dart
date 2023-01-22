import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier {
  String? sId;
  String? productCategory;
  String? productSubCategory;
  String? productName;
  int? productPrice;
  String? productImage;
  String? productRating;
  String? productDescription;
  String? productType;
  String? productSize;
  String? productColor;
  String? shopLocation;
  String? shopName;
  String? shopImage;
  String? shopRating;
  int? quantity;

  CartModel(
      {this.sId,
      this.productCategory,
      this.productSubCategory,
      this.productName,
      this.productPrice,
      this.productImage,
      this.productRating,
      this.productDescription,
      this.productType,
      this.productSize,
      this.productColor,
      this.shopLocation,
      this.shopName,
      this.shopImage,
      this.shopRating,
      this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productCategory = json['productCategory'];
    productSubCategory = json['productSubCategory'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productImage = json['productImage'];
    productRating = json['productRating'];
    productDescription = json['productDescription'];
    productType = json['productType'];
    productSize = json['productSize'];
    productColor = json['productColor'];
    shopLocation = json['shopLocation'];
    shopName = json['shopName'];
    shopImage = json['shopImage'];
    shopRating = json['shopRating'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productCategory'] = this.productCategory;
    data['productSubCategory'] = this.productSubCategory;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productImage'] = this.productImage;
    data['productRating'] = this.productRating;
    data['productDescription'] = this.productDescription;
    data['productType'] = this.productType;
    data['productSize'] = this.productSize;
    data['productColor'] = this.productColor;
    data['shopLocation'] = this.shopLocation;
    data['shopName'] = this.shopName;
    data['shopImage'] = this.shopImage;
    data['shopRating'] = this.shopRating;
    data['quantity'] = this.quantity;
    return data;
  }
}
