import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/screen/manages.dart';
import 'package:marchentapp/screen/orders.dart';
import 'package:marchentapp/screen/product.dart';
import 'package:marchentapp/widgets/textwidget.dart';

import 'homepsge.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectesindex = 1;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'HomeScreen'},
    {'page': const OrdersScreen(), 'title': 'OrdersScreen'},
    {'page': const ProductScreen(), 'title': 'ProductScreen'},
    {'page': const ManagesScreen(), 'title': 'ManagesScreen'},
    {'page': const ProductScreen(), 'title': 'ProductScreen'},
  ];
  void selectedpage(int index) {
    setState(() {
      selectesindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _pages[selectesindex]['page'],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FittedBox(
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          selectesindex = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 30,
                            color:
                                selectesindex == 0 ? Colors.blue : Colors.black,
                          ),
                          Textwidget(
                              text: 'Home',
                              color: selectesindex == 0
                                  ? Colors.blue
                                  : Colors.black,
                              fs: 18)
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          selectesindex = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.book,
                            size: 30,
                            color:
                                selectesindex == 1 ? Colors.blue : Colors.black,
                          ),
                          Textwidget(
                              text: 'Orders',
                              color: selectesindex == 1
                                  ? Colors.blue
                                  : Colors.black,
                              fs: 12)
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          selectesindex = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            size: 30,
                            color:
                                selectesindex == 2 ? Colors.blue : Colors.black,
                          ),
                          Textwidget(
                              text: 'Product',
                              color: selectesindex == 2
                                  ? Colors.blue
                                  : Colors.black,
                              fs: 12)
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          selectesindex = 3;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.manage_accounts,
                            size: 30,
                            color:
                                selectesindex == 3 ? Colors.blue : Colors.black,
                          ),
                          Textwidget(
                              text: 'Manages',
                              color: selectesindex == 3
                                  ? Colors.blue
                                  : Colors.black,
                              fs: 12)
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          selectesindex = 4;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                            color:
                                selectesindex == 4 ? Colors.blue : Colors.black,
                          ),
                          Textwidget(
                              text: 'Profile',
                              color: selectesindex == 4
                                  ? Colors.blue
                                  : Colors.black,
                              fs: 12)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
