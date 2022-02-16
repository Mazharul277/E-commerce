import 'package:e_commerce/E-Com/detail.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cart extends StatefulWidget {

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //DatabaseReference reference = FirebaseDatabase.instance.reference().child('E-Commerce');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        elevation: 0,
        title: Text('Cart Page', style: appBarText,),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('E-Commerce')
              .document(user.uid)
              .collection('product')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              );
            } else
              return ListView(
                  shrinkWrap: true,
                  children: snapshot.data.documents.map((document) {

                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      //color: Colors.red,
                      child: Card(
                        color: textFormColor,
                        child: ListTile(
                        title: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document['Product_Name'] ?? 'No Product Available',
                                ),
                                Text(
                                  'Price: ' + document['Product_Price'] ?? 'No Product Available',

                                ),
                              ],
                            ),
                            Spacer(),
                            FlatButton(
                                onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context) {
                                  return new AlertDialog(
                                  title: new Text("Are You sure Want to Delete"),
                                    content: Row(
                                      children: [
                                        FlatButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('Cancel')),
                                        FlatButton(
                                            onPressed: (){
                                          String productid = document.documentID;
                                          DocumentReference documentreference = Firestore.instance.collection('E-Commerce').document(user.uid).collection('product').document(productid);
                                          documentreference.delete().then((value) => Navigator.pop(context));
                                        }, child: Text('Delete'))
                                      ],
                                    ),
                                  );
                                  }
                                  );
                                },
                                child: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                    );
                  }).toList());
          }),
    );
  }
}
