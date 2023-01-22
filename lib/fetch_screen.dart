import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marchentapp/constss/consts.dart';
import 'package:marchentapp/screen/auth/loginpage.dart';
import 'package:marchentapp/screen/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});
  static const routename = '/FetchScreen';

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  //List<String> imagelist = Constss.imglist[0]['imagepath'];

  String? accessToken;
  String? idToken;
  String? email, password;
  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    accessToken = sharedPreferences.getString('accessToken').toString();
    idToken = sharedPreferences.getString('idToken').toString();
    email = sharedPreferences.getString('email').toString();
    password = sharedPreferences.getString('password').toString();

    print('email iss $email');
    print('password iss $password');
    print('accessToken iss $accessToken');
    print('idToken iss $idToken');

    if (accessToken!.isNotEmpty && idToken!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    ///  TODO: implement initState

    isLogin().whenComplete(() {
      Future.delayed(
          Duration(seconds: 3),
          (() => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return accessToken!.isNotEmpty && idToken!.isNotEmpty ||
                        email!.isNotEmpty && password!.isNotEmpty
                    ? BottomBar()
                    : LoginPage();
              }))));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Image.asset(
          './asset/image/jadurjinicom.png',
          fit: BoxFit.cover,
          height: size.height * 0.5,
        ),
      ),
    ));
  }
}
