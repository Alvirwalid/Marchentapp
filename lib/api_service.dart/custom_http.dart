import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marchentapp/model/productmodel.dart';

class CustomeHttp {
  Future<Map<String, String>> getheaderWithToken() async {
    Map<String, String> map = {
      'Accept': 'application/json',
      'Authorization': 'bearer 1031|8UzmvGgpH308JbOfRPYzsoKJUD2JMBT1fBlX9Du0'
    };

    //  print('object ${sharedPreferences.getString('token')}');
    return map;
  }

  Future<List<ProductModel>> fetchProductData() async {
    var link = 'https://jadurjini.vercel.app/products';

    List<ProductModel> productList = [];

    try {
      var respons =
          await http.get(Uri.parse(link), headers: await getheaderWithToken());

      // print('respons isss ${respons.body}');

      var data = jsonDecode(respons.body);

      ProductModel productModel;

      for (var i in data) {
        productModel = ProductModel.fromJson(i);

        productList.add(productModel);
      }

      // print("${productList[0].price}");

      return productList;
    } catch (e) {
      print(e.toString());
    }
    return productList;
  }
}
