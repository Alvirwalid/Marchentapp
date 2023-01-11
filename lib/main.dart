import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marchentapp/innerscreen/addproduct.dart';
import 'package:marchentapp/provider/productprovider.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:marchentapp/screen/homepsge.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomBar(),
        getPages: [
          GetPage(name: AddProduct.routename, page: () => AddProduct())
        ],
      ),
    );
  }
}
