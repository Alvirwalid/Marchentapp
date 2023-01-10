import 'package:flutter/cupertino.dart';
import 'package:marchentapp/api_service.dart/custom_http.dart';
import 'package:marchentapp/model/productmodel.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];

  Future getProductData() async {
    productList = await CustomeHttp().fetchProductData();
    notifyListeners();
  }
}
