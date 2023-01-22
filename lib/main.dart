import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marchentapp/fetch_screen.dart';
import 'package:marchentapp/innerscreen/addproduct.dart';
import 'package:marchentapp/innerscreen/addproductwithapi.dart';
import 'package:marchentapp/provider/orderprovider.dart';
import 'package:marchentapp/provider/productprovider.dart';
import 'package:marchentapp/screen/auth/loginpage.dart';
import 'package:marchentapp/screen/auth/register.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:marchentapp/screen/homepsge.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBCBS8cUvNI8muoR2yCWAErDCsxCFmEW2Q',
          appId: '1:875322725404:android:fe9f221b1a1dea572bfbd9',
          messagingSenderId: '875322725404',
          projectId: 'marchentapp-91955',
          authDomain: 'marchentapp-91955.firebaseapp.com'));
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
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: FetchScreen(),
        getPages: [
          GetPage(name: AddProduct.routename, page: () => AddProduct()),
          GetPage(
              name: AddproductWithApi.routename,
              page: () => const AddproductWithApi()),
          GetPage(name: BottomBar.routename, page: () => const BottomBar()),
          GetPage(name: LoginPage.routename, page: () => const LoginPage()),
          GetPage(
              name: RegisterScreens.routename,
              page: () => const RegisterScreens()),
          GetPage(name: FetchScreen.routename, page: () => const FetchScreen()),
        ],
      ),
    );
  }
}
