import 'package:e_commerce/UI/OTP/otp_verification.dart';
import 'package:e_commerce/configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  var _email = TextEditingController();
  var _password = TextEditingController();
  var _repassword = TextEditingController();

  var count = 0;

  void sendOTP() async {
    EmailAuth.sessionName = 'E-Commerce by Mazharul';
    var res = await EmailAuth.sendOtp(receiverMail: _email.text);
    if(res){
      print('Sent OTP Successfully');
    }else{
      showDialog(context: context, builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Please Enter Valid E-Mail"),
        );
      }
      );
    }
  }

  // void verifyOTP()async{
  //   var res = EmailAuth.validate(receiverMail: _emailController.text, userOTP: _otpController.text);
  //   if(res){
  //     count ++;
  //   }else{
  //     showDialog(context: context, builder: (BuildContext context) {
  //       return new AlertDialog(
  //         title: new Text("Invalid OTP"),
  //         content: new Text("Please Type Valid OTP"),
  //       );
  //     }
  //     );
  //   }
  // }

  final GlobalKey<FormState> _cformkey=GlobalKey<FormState>();
  Future<void> Sign_Up()async{
    final cformkey=_cformkey.currentState;
    if(cformkey.validate()){
      cformkey.save();
      try {
        if(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(_password.text) && _password.text == _repassword.text) {
          FirebaseUser newuser = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP_Verification(_email.text)));
          sendOTP();
        }
        else if(_email.text == '' || !_email.text.contains('@gmail.com')){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Enter an E-Mail'),
            );
          });
        }
        else if(!RegExp(r'^.{6,}$').hasMatch(_password.text)){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Enter Your Password more than 5 Characters'),
            );
          });
          //print('Enter Your Password more than 5');
        }
        else if(!RegExp(r'^(?=.*?[A-Z])').hasMatch(_password.text)){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Enter an Upper Case'),
            );
          });
          //print('Enter an Upper Case');
        }
        else if(!RegExp(r'^(?=.*?[a-z])').hasMatch(_password.text)){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Enter an Lower Case'),
            );
          });
          //print('Enter an Lower Case');
        }
        else if(!RegExp(r'^(?=.*?[0-9])').hasMatch(_password.text)){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Enter a Number'),
            );
          });
          //print('Enter a Number');
        }
        else if(!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(_password.text)){
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter a Special Character'),
            );
          });
          //print('Enter a Special Character');
        }
        else if(_password.text != _repassword){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Please Enter Same password'),
            );
          });
        }
      }
      catch(e){
      }
    }
  }

  bool hidenpass = true;
  void _togglePassView(){
    setState(() {
      hidenpass = !hidenpass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        elevation: 0,
        title: Text(
          "Create Your Account",
          style: buttonText,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              //Image
              Image(image: AssetImage('assets/images/sign_in_up/education.png')),

              //E-Mail
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                      hintText: "Enter Your E-Mail",
                    labelText: 'E-Mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    fillColor: textFormColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: textFormColor
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: textFormColor
                      ),
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),

              //Password + Repassword
              Form(
                key: _cformkey,
                    child: TextFormField(
                        controller: _password,
                        obscureText: hidenpass,
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Please Enter Password more than 5",
                          fillColor: textFormColor,
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                          prefixIcon: Icon(Icons.lock_outline),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: textFormColor
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: textFormColor
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          suffixIcon: InkWell(
                            //onTap: VisiblePassword,
                            onTap: _togglePassView,
                            child: hidenpass? Icon(Icons.visibility_off):Icon(Icons.visibility),
                          ),
                        ),
                      ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                controller: _repassword,
                obscureText: hidenpass,
                autofillHints: [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: 'Re-Password',
                  hintText: "Enter Confirm Password",
                  fillColor: textFormColor,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
                  prefixIcon: Icon(Icons.lock_outline),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: textFormColor
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: textFormColor
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),),

              //Button
              FlatButton(
                color: colors,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Create Account",style: buttonText,),
                onPressed: (){
                  Sign_Up();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
