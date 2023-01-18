import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:marchentapp/widgets/textwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constss/firebase_auth.dart';
import '../screen/bottombar.dart';
import '../service/globalmethod.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
//  String? user = FirebaseAuth.instance.currentUser!.uid;

  bool _isloaded = false;
  Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();

    final googleAccount = await googleSignIn.signIn();

    setState(() {
      _isloaded = true;
    });

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      print('Access token isss${googleAuth.accessToken}');
      print('Access token isss${googleAuth.idToken}');

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          sharedPreferences.setString(
              'accessToken', '${googleAuth.accessToken}');
          sharedPreferences.setString('idToken', '${googleAuth.idToken}');

          await authinstance.signInWithCredential(GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken));

          print('Login Successfully');
          setState(() {
            _isloaded = false;
          });

          Get.offAllNamed(BottomBar.routename, arguments: _isloaded);
        } on FirebaseAuthException catch (error) {
          print('An error occures $error');
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          setState(() {
            _isloaded = false;
          });

          print('An error occures $error');
        } catch (error) {
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          setState(() {
            _isloaded = false;
          });
          print('An error occures $error');
        } finally {
          setState(() {
            _isloaded = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                width: 40,
                child: Image.asset('asset/image/google.png')),
            const SizedBox(
              width: 20,
            ),
            Textwidget(text: 'Sign in with Google', color: Colors.white, fs: 18)
          ],
        ),
      ),
    );
  }
}
