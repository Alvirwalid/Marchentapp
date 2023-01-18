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
              child: Textwidget(text: '25', color: Colors.black),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: size.height * 0.05,
              ),
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            color: Color(0xff38C1F2)),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Textwidget(
                                text: '#AsDQ55s',
                                color: Colors.white,
                                fs: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Textwidget(
                                text: 'Sayeed Hassan',
                                color: Colors.white,
                                fs: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Textwidget(
                                text: '21 Dec,22',
                                color: Colors.white,
                                fs: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: Row(
                          children: [
                            Textwidget(
                              text: 'Total ',
                              color: Colors.black,
                              fs: 15,
                            ),
                            Spacer(),
                            Textwidget(
                              text: 'BDT 4,000 ',
                              color: Colors.black,
                              fs: 15,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Textwidget(
                                  text: '1xMens SweatShirt',
                                  color: Colors.black);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                            itemCount: 4),
                      )
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
