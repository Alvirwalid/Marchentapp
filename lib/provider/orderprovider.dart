import 'package:flutter/material.dart';
import 'package:marchentapp/model/cartmodel.dart';
import 'package:marchentapp/model/ordermodel.dart';

import '../api_service.dart/custom_http.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];
  List<CartModel> cartList = [];

  Future getOrderData() async {
    orderList = await CustomeHttp().fetchOrderData();
    notifyListeners();
  }
}
