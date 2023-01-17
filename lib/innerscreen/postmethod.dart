import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class PostMethod extends StatefulWidget {
  const PostMethod({super.key});

  @override
  State<PostMethod> createState() => _PostMethodState();
}

class _PostMethodState extends State<PostMethod> {
  // Future<dynamic> postMethod() async {
  //   var client = await http.Client();

  //   try {
  //     Map<String, dynamic> map = {'name': 'Alvirrrrrrrrrrrr', 'age': '2333'};

  //     var _payload = json.encode(map);

  //     var response = await client.post(
  //         Uri.parse('https://jadurjini.vercel.app/addproduct'),
  //         body: _payload);

  //     print(response.body);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<http.Response> createAlbum() {
    return http.post(
      Uri.parse('https://jadurjini.vercel.app/addproduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'title',
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await createAlbum();
                },
                child: Text('Post method'))
          ],
        ),
      ),
    );
  }
}
