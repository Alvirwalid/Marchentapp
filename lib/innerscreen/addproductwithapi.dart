import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../api_service.dart/custom_http.dart';
import '../constss/firebase_auth.dart';
import '../service/globalmethod.dart';
import '../widgets/textwidget.dart';

class AddproductWithApi extends StatefulWidget {
  const AddproductWithApi({super.key});
  static String routename = '/AddproductWithApi';

  @override
  State<AddproductWithApi> createState() => _AddproductWithApiState();
}

class _AddproductWithApiState extends State<AddproductWithApi> {
  final _productcategory = TextEditingController();
  final _subcatname = TextEditingController();
  final _productname = TextEditingController();
  final _productPrice = TextEditingController();
  final _productdetails = TextEditingController();
  final _productType = TextEditingController();
  final _productColor = TextEditingController();
  final _shopLocation = TextEditingController();
  final _shopName = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  List<XFile>? imagefiles;
  final ImagePicker imgpicker = ImagePicker();
  List<String> _imagesUrl = [];

  openImages() async {
    try {
      List<XFile> pickedfiles =
          await imgpicker.pickMultiImage(requestFullMetadata: true);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});

        print("imaaaage ${imagefiles![0].path.toString()}");
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  String? productimageurl;

  final User? user = authinstance.currentUser;
  String? shopimageUrl, loaction, rating, ShopName;
  Future<void> getUserData() async {
    try {
      final _uid = user!.uid;

      FirebaseFirestore.instance
          .collection('userinfo')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["shopname"]);

          ShopName = doc["shopname"];
          loaction = doc["location"];
          shopimageUrl = doc["imageurl"];
          rating = doc["rating"];
          setState(() {});
        });
      });
    } on FirebaseFirestore catch (error) {
      GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
    } catch (error) {
      GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
    }
  }

  Future createProduct() async {
    final uuid = Uuid().v4();

    try {
      int i = 0;
      for (XFile imageFile in imagefiles!) {
        try {
          var ref = FirebaseStorage.instance
              .ref()
              .child('ProductImages')
              .child(Uuid().v4())
              .child(i.toString() + '.jpg');

          await ref.putFile(File(imageFile.path));

          var url = await ref.getDownloadURL();

          _imagesUrl.add(url);
          setState(() {});

          ++i;
        } catch (err) {
          print(err);
        }
      }
      setState(() {});

      var response = await http.post(
        Uri.parse('https://jadurjini.vercel.app/addproduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'productCategory': _productcategory.text.toString(),
          'productSubCategory': _subcatname.text.toString(),
          'productName': _productname.text.toString(),
          'productPrice': _productPrice.text.toString(),
          'productRating': _rating,
          'productDescription': _productdetails.text.toString(),
          'productType': _productType.text.toString(),
          'productSize': _productSize,
          'productColor': _productColor.text.toString(),
          'shopLocation': loaction!,
          'shopName': ShopName!,
          'shopRating': rating!,
          'productImage': _imagesUrl,
          'shopImage': shopimageUrl!,
        }),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  _clearForm() async {
    setState(() {
      _productcategory.clear();
      _subcatname.clear();
      _productname.clear();
      _productPrice.clear();
      _productname.clear();
      _productdetails.clear();
      _productType.clear();
      _productColor.clear();
      _productSize = '';
      _rating = '';
      loaction = '';
      ShopName = '';
      _imagesUrl = [];
      shopimageUrl = '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _productname.dispose();
  //   _productcategory.dispose();
  //   _productPrice.dispose();
  //   _rating = '';
  //   _productdetails.dispose();
  //   _productdetails.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    var inputdecoration = InputDecoration(
        //  contentPadding: EdgeInsets.all(20),

        filled: true,
        fillColor: _scaffoldColor,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)));

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        //centerTitle: true,
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
                // _clearForm().whenComplete(() {
                //   Future.delayed(Duration(seconds: 1),
                //       (() => Navigator.of(context).pop()));
                // });
                //Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            Textwidget(
              text: 'Add Product',
              color: Colors.black,
              istitle: true,
              fs: 22,
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imagefiles != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: imagefiles!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5, crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Container(
                              child: Card(
                            child: Container(
                              // height: 100,
                              // width: 100,
                              child:
                                  Image.file(io.File(imagefiles![index].path)),
                            ),
                          ));
                        },
                      )
                    : InkWell(
                        onTap: () {
                          openImages();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xffF7F7F7)),
                          child: const Icon(
                            Icons.image,
                            size: 60,
                          ),
                        ),
                      ),

                SizedBox(
                  height: size.height * 0.025,
                ),
                Textwidget(
                  text: 'Product name',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  controller: _productname,
                  key: const ValueKey('name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product name';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(
                  text: 'Product category',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  controller: _productcategory,
                  key: const ValueKey('category'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product category';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textwidget(
                      text: 'Price',
                      color: Colors.black,
                      istitle: true,
                      fs: 15,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    TextFormField(
                      controller: _productPrice,
                      key: const ValueKey('Price'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter product Price';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _scaffoldColor,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(
                  text: 'Product Details',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),

                TextFormField(
                  controller: _productdetails,
                  key: const ValueKey('Enter Product details'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product details';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(
                  text: 'Product Type',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),

                TextFormField(
                  controller: _productType,
                  key: const ValueKey('Enter Product Type'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product Type';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(
                  text: 'Product Color',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  controller: _productColor,
                  key: const ValueKey('Color'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product Color';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(
                  text: 'Sub category name',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  controller: _subcatname,
                  key: const ValueKey('sub cat'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter sub category name';
                    } else {
                      return null;
                    }
                  },
                  decoration: inputdecoration,
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(text: 'Product Rating', color: Colors.black),
                _productRatingwidget(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Textwidget(text: 'Product Size', color: Colors.black),
                _productSizewidget(),

                SizedBox(
                  height: size.height * 0.015,
                ),

                /////////////////////////////////////////////////////////////////

                SizedBox(
                  height: size.height * 0.025,
                ),
                Textwidget(text: 'Add varients', color: Colors.black),
                SizedBox(
                  height: size.height * 0.1,
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        minimumSize: Size(size.width, 50),
                        backgroundColor:
                            const Color.fromARGB(255, 236, 176, 47)),
                    onPressed: () {
                      createProduct();
                    },
                    child: Textwidget(
                      text: 'Add Product',
                      color: Colors.black,
                      istitle: true,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _rating = '5.0';
  Widget _productRatingwidget() {
    return Container(
      //width: double.infinity,
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        style: GoogleFonts.quicksand(color: Colors.black, fontSize: 15),
        value: _rating,
        focusColor: Colors.red,
        iconEnabledColor: Colors.grey,
        onChanged: (value) {
          setState(() {
            _rating = value!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: '5.0',
            child: Text('5.0'),
          ),
          DropdownMenuItem(
            value: '4.0',
            child: Text('4.0'),
          ),
          DropdownMenuItem(
            value: '3.0',
            child: Text('3.0'),
          ),
          DropdownMenuItem(
            value: '2.0',
            child: Text('2.0'),
          ),
          DropdownMenuItem(
            value: '1.0',
            child: Text('1.0'),
          ),
        ],
      )),
    );
  }

  String _productSize = 'M';
  Widget _productSizewidget() {
    return Container(
      //width: double.infinity,
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        style: GoogleFonts.quicksand(color: Colors.black, fontSize: 15),
        value: _productSize,
        focusColor: Colors.red,
        iconEnabledColor: Colors.grey,
        onChanged: (value) {
          setState(() {
            _productSize = value!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'S',
            child: Text('S'),
          ),
          DropdownMenuItem(
            value: 'M',
            child: Text('M'),
          ),
          DropdownMenuItem(
            value: 'XL',
            child: Text('XL'),
          ),
          DropdownMenuItem(
            value: 'XXL',
            child: Text('XXL'),
          ),
        ],
      )),
    );
  }
}
