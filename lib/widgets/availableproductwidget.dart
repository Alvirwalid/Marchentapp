import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/widgets/textwidget.dart';
import 'package:provider/provider.dart';

import '../model/productmodel.dart';

class AvailableProduct extends StatelessWidget {
  AvailableProduct({super.key});
  //List<ProductModel> productList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productList = Provider.of<ProductModel>(context);

    return Container(
      height: size.height * 0.15,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffF7F7F7),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xffF5F5F7),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('${productList.image}'))),
              child: Text(''),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textwidget(
                    text: "${productList.name}",
                    color: Colors.black,
                    istitle: true,
                    fs: 18,
                  ),
                  Textwidget(
                    text: "BDT ${productList.price}",
                    color: Colors.black,
                    fs: 12,
                  ),
                  Spacer(),
                  Textwidget(
                    text: "In Stock: 45 Pcs",
                    color: Colors.black,
                    fs: 12,
                  ),
                  Textwidget(
                    text: "Last Restock: 60 Pcs",
                    color: Colors.black,
                    fs: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}