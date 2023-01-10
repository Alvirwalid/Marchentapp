import 'package:flutter/material.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:marchentapp/screen/homepsge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomBar(),
    );
  }
}