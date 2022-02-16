import 'package:e_commerce/E-Com/cart.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/E-Com/database.dart';

class Details extends StatefulWidget {

  var item, product_name, product_details, price, pic;
  Details(String this.item, String this.product_name,
      String this.product_details, String this.price, var this.pic);

  @override
  _DetailsState createState() => _DetailsState(this.item, this.product_name,
      this.product_details, this.price, this.pic);
}

class _DetailsState extends State<Details> {

  var item, product_name, product_details, price, pic,_category;
  _DetailsState(this.item, this.product_name, this.product_details, this.price,
      this.pic);

  final CollectionReference brewcollection = Firestore.instance.collection('E-Commerce');
  String uid;

  Future<void> sendDataProduct()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DataBaseProductService(uid: user.uid).UpdateUserData(
        product_name,price,_category = this.item
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        //automaticallyImplyLeading: false,
        title: Text('${this.item}', style: appBarText,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //Image
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: Image(image: NetworkImage(this.pic),),

            ),

            //Details
            Text(
              '${this.product_name}',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900),
            ),

            //Price
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child:Text(
              'Price: ৳${this.price}',
              style: TextStyle(
                  color: colors,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            ),

            //Details
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
              '${this.product_details}',
              style: TextStyle(
                  fontSize: 14,),
            ),
            ),

            SizedBox(height: 15,),
            //Add
            FlatButton(
                color: colors,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    )
                ),
                onPressed: () {
                  sendDataProduct();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                },
                child: Text('Add to Cart',style: buttonText)
            ),
                  ],
                ),
      )
      )
    );
  }
}
