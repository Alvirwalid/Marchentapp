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
  final _productname = TextEditingController();
  final _productcategory = TextEditingController();
  final _productType = TextEditingController();
  final _subcatname = TextEditingController();
  final _productPrice = TextEditingController();
  final _productColor = TextEditingController();
  final _productquantity = TextEditingController();
  final _productunit = TextEditingController();
  final _productdetails = TextEditingController();
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
  String? shopimageUrl, loaction, shoprating, ShopName;
  Future<void> getUserData() async {
    try {
      //final _uid = user!.uid;

      FirebaseFirestore.instance
          .collection('userinfo')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["shopname"]);

          setState(() {
            ShopName = doc["shopname"];
            loaction = doc["location"];
            shopimageUrl = doc["imageurl"];
            shoprating = doc["rating"];
          });
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
    setState(() {
      _imagesUrl = [];
    });

    try {
      int i = 0;
      for (XFile imageFile in imagefiles!) {
        var ref = FirebaseStorage.instance
            .ref()
            .child('ProductImages')
            .child(Uuid().v4())
            .child(i.toString() + '.jpg');

        await ref.putFile(File(imageFile.path));

        var url = await ref.getDownloadURL();

        setState(() {
          _imagesUrl.add(url);
        });

        ++i;
      }
      setState(() {});

      var response = await http.post(
        Uri.parse('https://jadurjini.vercel.app/addproduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'productName': _productname.text.toString(),
          'productCategory': _productcategory.text.toString(),
          'productType': _productType.text.toString(),
          'productSubCategory': _subcatname.text.toString(),
          'productPrice': _productPrice.text.toString(),
          'productColor': _productColor.text.toString(),
          'productquantity': _productquantity.text.toString(),
          'productRating': _rating,
          'productunit': _productunit.text.toString(),
          'productDescription': _productdetails.text.toString(),
          'shopLocation': loaction,
          'shopName': ShopName,
          'shopRating': shoprating,
          'productImage': _imagesUrl,
          'shopImage': shopimageUrl,
        }),
      );
    } catch (e) {
      print(e.toString());
    }
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
                SizedBox(
                  height: 10,
                ),
                imagefiles != null
                    ? Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: imagefiles!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  // height: 100,
                                  //  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(io.File(
                                              imagefiles![index].path)))),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          imagefiles!.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        IconlyBold.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: size.height * 0.07,
                            left: size.width * 0.40,
                            child: InkWell(
                              onTap: () {
                                openImages();
                              },
                              child: Icon(
                                Icons.image,
                                size: 40,
                              ),
                            ),
                          )
                        ],
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
                  fs: 16,
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
                  decoration: _inputdecoration(
                      Theme.of(context).scaffoldBackgroundColor, ' name'),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Textwidget(
                  text: 'Product category',
                  color: Colors.black,
                  istitle: true,
                  fs: 16,
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
                  decoration: _inputdecoration(
                      Theme.of(context).scaffoldBackgroundColor, 'category'),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),

                Textwidget(
                  text: 'Product Type',
                  color: Colors.black,
                  istitle: true,
                  fs: 16,
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
                  decoration: _inputdecoration(
                      Theme.of(context).scaffoldBackgroundColor, ' type'),
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),
                Textwidget(
                  text: 'Sub category name',
                  color: Colors.black,
                  istitle: true,
                  fs: 16,
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
                  decoration: _inputdecoration(
                      Theme.of(context).scaffoldBackgroundColor,
                      'sub category'),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Textwidget(
                  text: 'Quantity',
                  color: Colors.black,
                  istitle: true,
                  fs: 16,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  controller: _productquantity,
                  key: const ValueKey('quantity'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter sub quantity';
                    } else {
                      return null;
                    }
                  },
                  decoration: _inputdecoration(
                      Theme.of(context).scaffoldBackgroundColor, 'quantity'),
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Textwidget(
                          text: 'Price',
                          color: Colors.black,
                          istitle: true,
                          fs: 16,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          child: TextFormField(
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
                              hintText: ' price',
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]'))
                            ],
                          ),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Textwidget(
                          text: ' Color',
                          color: Colors.black,
                          istitle: true,
                          fs: 16,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _productColor,
                            key: const ValueKey('Color'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter product Color';
                              } else {
                                return null;
                              }
                            },
                            decoration: _inputdecoration(
                                Theme.of(context).scaffoldBackgroundColor,
                                ' color'),
                          ),
                        )
                      ],
                    )),
                  ],
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: 'Product Rating',
                          color: Colors.black,
                          fs: 16,
                          istitle: true,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        _productRatingwidget(),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Textwidget(
                          text: 'Product unit',
                          color: Colors.black,
                          istitle: true,
                          fs: 16,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _productunit,
                            key: const ValueKey('Productunit'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' product unit';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _scaffoldColor,
                              hintText: ' unit',
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                        )
                      ],
                    )),
                  ],
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Textwidget(
                  text: 'Product Details',
                  color: Colors.black,
                  istitle: true,
                  fs: 16,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),

                TextFormField(
                  //minLines: 20,
                  maxLines: 6,
                  controller: _productdetails,
                  keyboardType: TextInputType.multiline,
                  key: const ValueKey('Enter Product details'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter product details';
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
                          borderSide: BorderSide(color: Colors.transparent))),
                ),

                // ////////////////////////////////////////////////////////////////

                SizedBox(
                  height: size.height * 0.025,
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
                      color: Colors.white,
                      istitle: true,
                    )),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputdecoration(Color _scaffoldColor, String text) {
    return InputDecoration(
        //  contentPadding: EdgeInsets.all(20),

        filled: true,
        fillColor: _scaffoldColor,
        border: InputBorder.none,
        hintText: text,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)));
  }

  String _rating = '5.0';
  Widget _productRatingwidget() {
    return Container(
      width: 175,
      height: 60,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10)),
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
}
