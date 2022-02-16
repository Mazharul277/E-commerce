import 'dart:io';
import 'package:e_commerce/E-Com/user_history.dart';
import 'package:e_commerce/UI/SIGNING/sign_in.dart';
import 'package:e_commerce/configs.dart';
import 'package:e_commerce/loader.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin_Page extends StatefulWidget {
  @override
  _Admin_PageState createState() => _Admin_PageState();
}

class _Admin_PageState extends State<Admin_Page> {
  String category;
  //String _product_name, _product_price, _product_details, image;

  var _product_name = TextEditingController();
  var _product_price = TextEditingController();
  var _product_details = TextEditingController();


  Firestore firestore = Firestore.instance;

  String productchose;
  List productitem = [
    "Women",
    "Men",
    "Devices",
    "Gadgets",
    "Games",
    'Agriculture',
    'Education',
    'Home & Living',
    'Pets & Animal',
    'Vehicle'
  ];

  Future<void> sendData() async {
    var storageImage = FirebaseStorage.instance.ref().child(_image.path);
    var task = storageImage.putFile(_image);
    String imgurl = await (await task.onComplete).ref.getDownloadURL();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await (imgurl);
    firestore.collection(category).add({
      '_Product_Name': _product_name.text,
      '_Product_Price': _product_price.text,
      '_Product_Details': _product_details.text,
      'Image': imgurl,
    });
  }

  File _image;
  Future cameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future galleryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors,
        elevation: 0,
        title: Center(child: Text('Admin Panel')),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>User_History()));
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => Sign_in()),
                //     (route) => false);
              },
              child: Text('Order History',style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [

            //DropDown
            Center(
              child: DropdownButton(
                iconEnabledColor: Colors.black,
                //style: TextStyle(decorationColor: Colors.white),
                dropdownColor: textFormColor,
                hint: Text(
                  "Select a Category",
                  //style: TextStyle(color: Colors.white),
                ),
                value: productchose,
                onChanged: (newValue) {
                  setState(() {
                    productchose = newValue;
                  });
                },
                items: productitem.map((valueitem) {
                  if (productchose == 'Women') {
                    category = 'Women';
                  } else if (productchose == 'Men') {
                    category = 'Men';
                  } else if (productchose == 'Devices') {
                    category = 'Devices';
                  } else if (productchose == 'Gadgets') {
                    category = 'Gadgets';
                  } else if (productchose == 'Games') {
                    category = 'Games';
                  } else if(productchose == 'Agriculture'){
                    category = 'Agriculture';
                  } else if(productchose == 'Education'){
                    category = 'Education';
                  } else if(productchose == 'Home & Living'){
                    category = 'Home & Living';
                  } else if(productchose == 'Pets & Animal'){
                    category = 'Pets & Animal';
                  } else if(productchose == 'Vehicle'){
                    category = 'Vehicle';
                  }
                  print(category);
                  return DropdownMenuItem(
                      value: valueitem,
                      child: Text(
                        valueitem,
                        style: TextStyle(color: Colors.black),
                      ));
                }).toList(),
              ),
            ),

            //Product Name
            Padding(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              child: TextFormField(
              controller: _product_name,
              style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Product Name *',
                hintText: 'Enter Product Name',
                fillColor: Color(0xFFffffff),
                filled: true,
                labelStyle: TextStyle(fontSize: 16),
                hintStyle: TextStyle(fontSize: 16),
                //prefixIcon: Icon(Icons.account_circle),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: colors,
                      width: 2
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFfffff),
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
              ),
            ),),

            //Product Price
            TextFormField(
              controller: _product_price,
              style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
              autofocus: false,
              maxLength: 8,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counter: Offstage(),
                labelText: 'Product Price*',
                hintText: 'Enter Product Price',
                fillColor: Color(0xFFffffff),
                filled: true,
                labelStyle: TextStyle(fontSize: 16),
                hintStyle: TextStyle(fontSize: 16),
                //prefixIcon: Icon(Icons.account_circle),
                suffix: Visibility(
                  visible: true,
                  child: Text('৳      ',style: TextStyle(fontSize: 20),),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: colors,
                      width: 2
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFfffff),
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
              ),
            ),

            //Product Details
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
              controller: _product_details,
              style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
              maxLines: 5,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Product Details*',
                hintText: 'Enter Product Details',
                fillColor: Color(0xFFffffff),
                filled: true,
                labelStyle: TextStyle(fontSize: 16),
                hintStyle: TextStyle(fontSize: 16),
                //prefixIcon: Icon(Icons.account_circle),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: colors,
                      width: 2
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Color(0xFFfffff),
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.only(top: 10, left: 20),
                //suffixIcon: name.text.length > 0 ? Icon(Icons.done) : Icon(Icons.pin)
              ),
            ),),

            //Image
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width *0.8,
                decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  border: Border.all(
                      width: 2,
                      color: Color(0xFFffffff)
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: _image != null ? Stack(
                    children:[
                      Center(child: Image.file(_image,)),
                      Positioned(
                          right: -2,
                          top: -9,
                          child: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.black.withOpacity(0.5),
                                size: 18,
                              ),
                              onPressed: () => setState(() {
                                _image = null;
                              })))
                    ]) :
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                    children: [
                      Text('Select Your Image'),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              cameraImage();
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: colors,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              galleryImage();
                            },
                            child: Icon(Icons.photo_library_outlined,
                                color: colors
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Send Button
            FlatButton(
              color: colors,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                onPressed: (){
                Loader().showLoaderDialog(context);
                  sendData().then((value) =>{_product_name.text = '', _product_price.text = '', _product_details.text = ''});
                },
                child: Text('Save Product',style: buttonText,)
            ),

            SizedBox(height: 15,)
          ],
        ),
      ),
      ),
    );
  }
}
