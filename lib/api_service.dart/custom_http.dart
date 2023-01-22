import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marchentapp/model/ordermodel.dart';
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

  Future<List<OrderModel>> fetchOrderData() async {
    var link = 'http://jadurjini.vercel.app/order';

    List<OrderModel> orderList = [];

    try {
      var respons =
          await http.get(Uri.parse(link), headers: await getheaderWithToken());

      //print('respons isss ${respons.body}');

      var data = jsonDecode(respons.body);

      OrderModel orderModel;

      for (var i in data) {
        orderModel = OrderModel.fromJson(i);

        orderList.add(orderModel);
      }

      // print("${productList[0].price}");

      return orderList;
    } catch (e) {
      print(e.toString());
    }
    return orderList;
  }
}
