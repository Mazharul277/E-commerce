import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/E-Com/detail.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductDetails extends StatefulWidget {

  var item;
  ProductDetails(this.item);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        title: Text('${widget.item} Categories'),
        centerTitle: true,
      ),

      body:
      StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('${widget.item}').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...',style: TextStyle(color: Colors.white),));
            } else
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Details(widget.item, snapshot.data.documents[index].data['_Product_Name'],
                          snapshot.data.documents[index].data['_Product_Details'], snapshot.data.documents[index].data['_Product_Price'],snapshot.data.documents[index].data['Image'])));
                    },
                    child: Card(
                      //color: backColor,
                      //margin: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(snapshot.data.documents[index].data['Image'] != null ? snapshot.data.documents[index].data['Image'] : '',
                                fit: BoxFit.fill,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 3),
                                child: Text(snapshot.data.documents[index].data['_Product_Name'] != null ? snapshot.data.documents[index].data['_Product_Name'] : '',style: TextStyle(fontSize: 20),),
                              ),
                              Text('৳ ${snapshot.data.documents[index].data['_Product_Price'] != null ? snapshot.data.documents[index].data['_Product_Price'] : ''}', style: TextStyle(color: colors, fontSize: 18))

                            ],
                          ),
                        )
                    ),
                  );
                },

                staggeredTileBuilder: (int index) =>
                    StaggeredTile.fit(1),
              );
          }
      ),

    );
  }
}