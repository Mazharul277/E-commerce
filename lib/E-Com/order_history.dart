import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order_History extends StatefulWidget {

  String userid;
  Order_History(this.userid);

  @override
  _Order_HistoryState createState() => _Order_HistoryState(this.userid);
}

class _Order_HistoryState extends State<Order_History> {
  String userid;

  _Order_HistoryState(this.userid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        elevation: 0,
        title: Center(child: Text('Order Details')),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('E-Commerce')
              .document(userid)
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

                    return Card(
                      // height: MediaQuery.of(context).size.height * 0.09,
                      // width: MediaQuery.of(context).size.width,
                      //color: Colors.red,
                      child: ListTile(
                          title: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['Product_Category'] ?? 'No Product Available',
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    document['Product_Name'] ?? 'No Product Available',
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Price: ৳ ' + document['Product_Price'] ?? 'No Product Available',
                                    // style: TextStyle(color: Colors.white),
                                  )
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
                                                  DocumentReference documentreference = Firestore.instance.collection('E-Commerce').document(userid).collection('product').document(productid);
                                                  documentreference.delete().then((value) => Navigator.pop(context));
                                                }, child: Text('Delete'))
                                          ],
                                        ),
                                      );
                                    }
                                    );
                                  },
                                  child: Icon(Icons.delete,))
                            ],
                          ),
                          ),
                    );
                  }).toList());
          }),
    );
  }
}
