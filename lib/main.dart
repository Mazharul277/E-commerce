
import 'package:e_commerce/E-Com/open_splash.dart';
import 'package:e_commerce/PRODUCT/categories.dart';
import 'package:e_commerce/UI/OTP/otp_verification.dart';
import 'package:e_commerce/UI/PROFILE/profile.dart';
import 'package:e_commerce/UI/SIGNING/information.dart';
import 'package:e_commerce/UI/SIGNING/sign_in.dart';
import 'package:e_commerce/UI/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.mcLarenTextTheme(
          Theme.of(context).textTheme
        ),
        primarySwatch: Colors.red,
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return Body();
          }
          else{
            return Sign_in();
          }
        },
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}
