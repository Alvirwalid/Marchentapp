import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marchentapp/screen/auth/loginpage.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  //List<String> imagelist = Constss.imglist[0]['imagepath'];

  var accessToken;
  var idToken;
  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    accessToken = sharedPreferences.getString('accessToken');
    print('accessToken iss $accessToken');
    print('idToken iss $idToken');

    if (accessToken != null && idToken != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    isLogin().whenComplete(() {
      Future.delayed(
          Duration(seconds: 2),
          (() => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return accessToken != null ? BottomBar() : LoginPage();
              }))));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            './asset/image/landing/buyfood.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
