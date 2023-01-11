import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/textwidget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static String routename = '/AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _productname = TextEditingController();
  final _productcategory = TextEditingController();
  final _price = TextEditingController();
  final _discount = TextEditingController();
  final _productdetails = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _productname.dispose();
  //   _productcategory.dispose();
  //   _price.dispose();
  //   _discount.dispose();
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
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                  height: size.height * 0.01,
                ),
                Textwidget(
                  text: 'Add product image(up to 5)',
                  color: Colors.black,
                  istitle: true,
                  fs: 15,
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
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
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
                              controller: _price,
                              key: const ValueKey('Price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter product Discount';
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
                            )
                          ],
                        )),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textwidget(
                              text: 'Discount price',
                              color: Colors.black,
                              istitle: true,
                              fs: 15,
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TextFormField(
                              controller: _discount,
                              key: const ValueKey('Discount'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter product Discount';
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
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                _productUnit(),
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
                    onPressed: () {},
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

  String _unit = 'Kg';

  Widget _productUnit() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        style: GoogleFonts.quicksand(color: Colors.black, fontSize: 15),
        value: _unit,
        focusColor: Colors.red,
        iconEnabledColor: Colors.grey,
        onChanged: (value) {
          setState(() {
            _unit = value!;
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Piece',
            child: Text('Piece'),
          ),
          DropdownMenuItem(
            value: 'Kg',
            child: Text('Kg'),
          ),
        ],
      )),
    );
  }
}
