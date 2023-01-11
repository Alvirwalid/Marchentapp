import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/productmodel.dart';
import '../provider/productprovider.dart';
import '../widgets/availableproductwidget.dart';
import '../widgets/textwidget.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  List<ProductModel> productList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var productprovider =
        Provider.of<ProductProvider>(context).getProductData();

    productList = Provider.of<ProductProvider>(context).productList;
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
              text: 'Stock Analytics',
              color: Colors.black,
              istitle: true,
              fs: 22,
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textwidget(text: 'Product In', color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          Textwidget(
                            text: '500',
                            color: Colors.black,
                            istitle: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Textwidget(text: 'Product Out', color: Colors.grey),
                          const SizedBox(
                            height: 15,
                          ),
                          Textwidget(
                            text: '400',
                            color: Colors.black,
                            istitle: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      minimumSize: Size(size.width, 50),
                      backgroundColor: const Color.fromARGB(255, 236, 176, 47)),
                  onPressed: () {},
                  child: Textwidget(
                    text: 'Add Product',
                    color: Colors.black,
                    istitle: true,
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              Textwidget(
                text: 'Available Product List',
                color: Colors.black,
                fs: 15,
                istitle: true,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: productList[index], child: AvailableProduct());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
