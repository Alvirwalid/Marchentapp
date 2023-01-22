import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/model/cartmodel.dart';
import 'package:marchentapp/model/modelcart.dart';
import 'package:marchentapp/model/ordermodel.dart';
import 'package:marchentapp/provider/orderprovider.dart';
import 'package:marchentapp/screen/loadingmanager.dart';
import 'package:provider/provider.dart';

import '../widgets/textwidget.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  List<OrderModel> orderList = [];
  List<CartModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var orderprovider = Provider.of<OrderProvider>(context).getOrderData();

    orderList = Provider.of<OrderProvider>(context).orderList;
    cartList = Provider.of<OrderProvider>(context).cartList;

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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffFFDB8C)),
              child: Textwidget(
                text: '25',
                color: Colors.black,
                fs: 12,
              ),
            )
          ],
        ),
      ),
      body: Loadingmanager(
        isLoading: false,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: orderList.length,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: size.height * 0.02,
                ),
                itemBuilder: (context, x) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              color: Color(0xffFFB000)),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Textwidget(
                                  text: '${orderList[x].sId}',
                                  color: Colors.white,
                                  fs: 15,
                                  istitle: true,
                                ),
                                SizedBox(
                                  width: size.width * 0.06,
                                ),
                                Textwidget(
                                  text: '${orderList[x].dbUser!.name}',
                                  color: Colors.white,
                                  fs: 15,
                                  istitle: true,
                                ),
                                SizedBox(
                                  width: size.width * 0.06,
                                ),
                                Textwidget(
                                  text: '21 Dec,22',
                                  color: Colors.white,
                                  fs: 15,
                                  istitle: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: orderList[x].cart!.length,
                            itemBuilder: (context, index) {
                              var price = 0;
                              price = price +
                                  int.parse(
                                      '${orderList[x].cart![index].productPrice}');
                              return Textwidget(
                                text:
                                    '${orderList[x].cart![index].productName}',
                                color: Colors.black,
                                fs: 15,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(130, 40),
                                      backgroundColor: Colors.red),
                                  onPressed: () {},
                                  child: Textwidget(
                                    text: 'Cancel',
                                    color: Colors.white,
                                    fs: 15,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(130, 40),
                                      backgroundColor: Colors.green),
                                  onPressed: () {},
                                  child: Textwidget(
                                    text: 'Confirm',
                                    color: Colors.white,
                                    fs: 15,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
