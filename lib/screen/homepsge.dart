import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/constss/consts.dart';
import 'package:marchentapp/model/productmodel.dart';
import 'package:marchentapp/provider/productprovider.dart';
import 'package:marchentapp/widgets/textwidget.dart';
import 'package:provider/provider.dart';

import '../widgets/cardwidget.dart';
import '../widgets/topsaleproduct.dart';
import '../constss/flchart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> productList = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var productprovider =
        Provider.of<ProductProvider>(context).getProductData();

    productList = Provider.of<ProductProvider>(context).productList;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Textwidget(
            text: 'Home',
            color: Colors.black,
            istitle: true,
            fs: 22,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  CardWidget(
                    title: 'Todays Sales',
                    fs: 15,
                    color: Colors.grey,
                    text: 'BDT  25,000',
                    // pfs: 18,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Panding Orders',
                    fs: 15,
                    color: Colors.grey,
                    text: '25',
                    // pfs: 22,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Stock Available',
                    fs: 15,
                    color: Colors.grey,
                    text: '500',
                    // pfs: 22,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Todays Order',
                    fs: 15,
                    color: Colors.grey,
                    text: 'BDT  20,000',
                    // pfs: 22,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Textwidget(
                  text: 'Order Overview',
                  color: Colors.black,
                  istitle: true,
                  fs: 20,
                ),
              ),
              //   LineChartWidget()
              const SizedBox(
                height: 10,
              ),
              Container(
                // color: Colors.amber,
                width: double.infinity,
                height: 300,
                child: LineChartWidget(),
              ),
              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Textwidget(
                      text: 'Top Selling Product',
                      color: Colors.black,
                      istitle: true,
                      fs: 20,
                    ),
                    Spacer(),
                    Textwidget(text: 'More', color: Colors.black)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              productList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: productList.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            // fit: BoxFit.fill,
                                            // opacity: 0.9,
                                            image: NetworkImage(
                                                "${productList[index].image}"))),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Textwidget(
                                  text: "BDT ${productList[index].price}",
                                  color: Colors.black,
                                  fs: 16,
                                  istitle: true,
                                ),
                              ],
                            ),
                          );
                          ;
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: Constss.phonelist.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            // opacity: 0.9,
                                            image: AssetImage(
                                                './asset/image/phone.png'))),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Textwidget(
                                  text: "BDT 5000",
                                  color: Colors.black,
                                  fs: 16,
                                  istitle: true,
                                ),
                              ],
                            ),
                          );
                          ;
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
