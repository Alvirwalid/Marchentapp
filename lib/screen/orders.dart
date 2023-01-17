import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/textwidget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            Textwidget(
              text: 'Pending Order List',
              color: Colors.black,
              istitle: true,
              fs: 22,
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffFFDB8C)),
              child: Text('25'),
            )
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
              children: [],
            ));
          },
        )),
      ),
    );
  }
}
