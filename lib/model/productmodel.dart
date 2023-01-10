class ProductModel {
  String? sId;
  String? name;
  String? image;
  int? price;
  String? shopLocation;
  String? shopName;

  ProductModel(
      {this.sId,
      this.name,
      this.image,
      this.price,
      this.shopLocation,
      this.shopName});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    shopLocation = json['shopLocation'];
    shopName = json['shopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['shopLocation'] = this.shopLocation;
    data['shopName'] = this.shopName;
    return data;
  }
}
