import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/widgets/textwidget.dart';

import '../constss/consts.dart';

class TopSaleCard extends StatelessWidget {
  TopSaleCard({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.9,
                image: NetworkImage(
                    "${Constss.topSaleProduct[index]['imageUrl']}"))),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Textwidget(
            text: "${Constss.topSaleProduct[index]['price']}",
            color: Colors.black,
            fs: 16,
            istitle: true,
          ),
        ),
      ),
    );
  }
}
