import 'package:e_commerce/UI/SIGNING/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Open extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      //image: Image(image: AssetImage('assets/images/sign_in_up/splash.png'),height: 200,),
      navigateAfterSeconds: Sign_in(),
      seconds: 2,
      loadingText: Text('Excel IT E-Commerce',style: TextStyle(fontSize: 20),),
    );
  }
}
