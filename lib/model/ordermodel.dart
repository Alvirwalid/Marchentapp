class OrderModel {
  String? sId;
  Address? address;
  List<Cart>? cart;
  DbUser? dbUser;
  String? userId;
  String? date;
  int? subtotal;
  int? shipping;

  OrderModel(
      {this.sId,
      this.address,
      this.cart,
      this.dbUser,
      this.userId,
      this.date,
      this.subtotal,
      this.shipping});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    dbUser =
        json['dbUser'] != null ? new DbUser.fromJson(json['dbUser']) : null;
    userId = json['userId'];
    date = json['date'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    if (this.dbUser != null) {
      data['dbUser'] = this.dbUser!.toJson();
    }
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    return data;
  }
}

class Address {
  String? streetAddress;
  String? city;
  String? state;
  String? zip;

  Address({this.streetAddress, this.city, this.state, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetAddress'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    return data;
  }
}

class Cart {
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

  Cart(
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

  Cart.fromJson(Map<String, dynamic> json) {
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

class DbUser {
  String? sId;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;

  DbUser({this.sId, this.name, this.email, this.phoneNumber, this.password});

  DbUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    return data;
  }
}
