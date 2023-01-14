import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marchentapp/innerscreen/addproduct.dart';
import 'package:marchentapp/provider/productprovider.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:marchentapp/screen/homepsge.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBCBS8cUvNI8muoR2yCWAErDCsxCFmEW2Q',
          appId: '1:875322725404:android:fe9f221b1a1dea572bfbd9',
          messagingSenderId: '875322725404',
          projectId: 'marchentapp-91955',
          authDomain: 'marchentapp-91955.firebaseapp.com'));
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
