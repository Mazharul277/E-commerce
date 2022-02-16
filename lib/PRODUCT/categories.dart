import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/MODEL/category.dart';
import 'package:e_commerce/PRODUCT/product_details.dart';
import 'package:e_commerce/UI/PROFILE/profile.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';
import '../E-Com/cart.dart';
import '../E-Com/detail.dart';

class All_Pages extends StatefulWidget {

  @override
  _All_PagesState createState() => _All_PagesState();
}

class _All_PagesState extends State<All_Pages> {


  var item = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        automaticallyImplyLeading: false,
        title: Text('Categories'),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GridView.builder(
                  itemCount: Category().lists.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 110,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index){
                    var data = Category().lists;
                    return GestureDetector(
                      onTap: (){
                        print('Success Press');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(data[index].item_name)));
                      },
                      child: Card(
                        color: textFormColor,
                        shadowColor: colors,
                        elevation: 3,
                        //margin: EdgeInsets.only(top: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: Image(
                                image: AssetImage(data[index].item_image),
                                height: 50,
                              ),
                            ),
                            Text(data[index].item_name, style: cardText,)
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
    );
  }
}