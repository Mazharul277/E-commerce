import 'package:e_commerce/UI/SIGNING/sign_in.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../E-Com/cart.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fname,lname,address,gmail,imageurl;

  _fetch()async{
    final firebaseUser = await FirebaseAuth.instance.currentUser();
    if(firebaseUser!=null)
      await Firestore.instance.collection('E-Commerce').document(firebaseUser.uid).get().then((ds){
        fname=ds.data['First_Name'];
        address=ds.data['Address'];
        gmail=ds.data['E-Mail'];
        imageurl = ds.data['Image'];
      }).catchError((e){
        print(e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
            backgroundColor: colors,
            title: Text('Profile', style: appBarText,),
            centerTitle: true,
          ),
          body:SingleChildScrollView( child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Image + Name + EMail
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35,left: 15, right: 15),
                      child:
                      FutureBuilder(
                        future: _fetch(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState!= ConnectionState.done)
                            return Center(child: CircularProgressIndicator());
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(imageurl),
                              ),

                            ],
                          );
                        },
                      ),
                    ),


                    FutureBuilder(
                      future: _fetch(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState!= ConnectionState.done)
                          return Center(child: Text("No Data Available..",));
                        return Column(
                          children: [
                            Text("$fname",style: TextStyle(fontSize: 20),),
                            Text("$gmail", style: TextStyle(color: colors),)
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              //Edit Profile
              Padding(
                padding: const EdgeInsets.only(left: 28,top: 15, bottom: 25),
                child: FlatButton(onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Info()));
                }, child: Text('Edit Profile')),
              ),

              //Address
            FlatButton(
              onPressed: (){
                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Sign_in()), (route) => false);
              },
              child: Row(
                  children: [
                    Container(
                     color: colors,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Icon(Icons.add_location_alt_outlined, color: textFormColor,),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
                    FutureBuilder(
                      future: _fetch(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState!= ConnectionState.done)
                          return Text("No Data Available..");
                        return Column(
                          children: [
                            Text("$address",style: TextStyle(fontSize: 20),),
                          ],
                        );
                      },
                    ),
                  ],
                ),
            ),

              //Order History
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: FlatButton(
                  onPressed: (){
                    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Sign_in()), (route) => false);
                  },
                  child: Row(
                  children: [
                    Container(
                      color: colors,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Icon(Icons.circle, color: textFormColor,),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
                    Text('Order History',style: TextStyle(fontSize: 20),)
                  ],
                ),
                ),
              ),

              //Carts
              FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                  },
                  child: Row(
                    children: [
                      Container(
                        color: colors,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Icon(Icons.card_giftcard, color: textFormColor,),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
                      Text('Carts',style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),

              //Logout
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Sign_in()), (route) => false);
                  },
                  child: Row(
                    children: [
                      Container(
                        color: colors,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Icon(Icons.login_outlined, color: textFormColor,),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
                      Text('Log Out',style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
              )
            ],
          ),)
        )
    );
  }
}
