import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marchentapp/constss/consts.dart';
import 'package:marchentapp/widgets/textwidget.dart';

import '../widgets/cardwidget.dart';
import '../widgets/topsaleproduct.dart';
import '../constss/flchart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leadingWidth: 130,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              Textwidget(
                text: 'Home',
                color: Colors.black,
                istitle: true,
                fs: 24,
              )
            ],
          ),
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
                height: size.height * 0.03,
              ),
              GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  CardWidget(
                    title: 'Todays Sales',
                    fs: 16,
                    color: Colors.grey,
                    text: 'BDT  25,000',
                    // pfs: 18,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Panding Orders',
                    fs: 16,
                    color: Colors.grey,
                    text: '25',
                    // pfs: 22,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Stock Available',
                    fs: 16,
                    color: Colors.grey,
                    text: '500',
                    // pfs: 22,
                    procecolor: Colors.black,
                    istitle: true,
                  ),
                  CardWidget(
                    title: 'Todays Order',
                    fs: 16,
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
              Textwidget(
                text: 'Order Overview',
                color: Colors.black,
                istitle: true,
                fs: 24,
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
                height: 20,
              ),

              Row(
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
              SizedBox(
                height: 10,
              ),

              GridView.builder(
                itemCount: Constss.topSaleProduct.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return TopSaleCard(
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
