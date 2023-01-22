import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:marchentapp/constss/firebase_auth.dart';
import 'package:marchentapp/screen/auth/loginpage.dart';
import 'package:marchentapp/screen/loadingmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/globalmethod.dart';
import '../widgets/textwidget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? id;
  bool _isLoading = false;
  final User? user = authinstance.currentUser;

  Future<void> getUserdata() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      email = user!.email;
      id = user!.uid;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _clearData() async {}

  @override
  void initState() {
    // TODO: implement initState
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              text: 'Profile',
              color: Colors.black,
              istitle: true,
              fs: 22,
            ),
          ],
        ),
        // actions: [
        //   CircleAvatar(
        //     backgroundColor: Color(0xff38C1F2),
        //     radius: 16,
        //     child: Icon(
        //       Icons.edit,
        //       color: Colors.white,
        //       size: 20,
        //     ),
        //   ),
        //   SizedBox(
        //     width: 15,
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Loadingmanager(
          isLoading: _isLoading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffDCEDFF),
                  radius: 80,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Textwidget(text: 'Sayeed Hassan', color: Colors.black),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Textwidget(
                    text: email == null ? 'Email' : '$email',
                    color: Colors.black),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Textwidget(
                    text: id == null ? '01753904301' : '01753904301',
                    color: Colors.black),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      _listtile(
                          icon: IconlyBold.message,
                          title: 'Messeges',
                          onpressed: () {}),
                      _listtile(
                          icon: IconlyBold.setting,
                          title: 'Setting',
                          onpressed: () {}),
                      _listtile(
                          icon: Icons.info,
                          title: 'About us',
                          onpressed: () {}),
                      _listtile(
                          icon: IconlyBold.star,
                          title: 'Rate',
                          onpressed: () {}),
                      _listtile(
                          icon: user == null
                              ? IconlyLight.login
                              : IconlyLight.logout,
                          title: user == null ? 'Login' : 'Logout',
                          onpressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            setState(() {
                              pref.setString('email', '');
                              pref.setString('password', '');
                              pref.setString('accessToken', '');
                              pref.setString('idToken', '');
                            });
                            if (user == null) {
                              Get.toNamed(LoginPage.routename);
                              return;
                            }
                            GlobalMethod.warningDialog(
                                ctx: context,
                                title: 'Signout',
                                subtitle: 'Do you wanna signout',
                                onpressed: () async {
                                  await authinstance.signOut();

                                  Get.offAndToNamed(LoginPage.routename);
                                });
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _listtile(
      {required IconData icon,
      required String title,
      required Function onpressed}) {
    return ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Icon(
          icon,
          color: Colors.black,
          size: 26,
        ),
      ),
      title: Textwidget(text: title, color: Colors.black, fs: 16),
      onTap: () {
        onpressed();
      },
    );
  }
}
