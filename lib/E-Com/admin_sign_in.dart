import 'package:e_commerce/E-Com/admin_page.dart';
import 'package:e_commerce/UI/SIGNING/sign_up.dart';
import 'package:e_commerce/configs.dart';
import 'package:e_commerce/loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Admin_Sign_In extends StatefulWidget {
  @override
  _Admin_Sign_InState createState() => _Admin_Sign_InState();
}

class _Admin_Sign_InState extends State<Admin_Sign_In> {

  var _email = TextEditingController();
  var _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> SignIn() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: "shamol.admin@gmail.com", password: _password.text);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Admin_Page()), (route) => false);
      } catch (e) {
        print(e.message);
        if(e.message == 'The password is invalid or the user does not have a password.' ||
            e.message == 'Ignoring header X-Firebase-Locale because its value was null.' ||
            e.message == 'We have blocked all requests from this device due to unusual activity. Try again later. [ Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later. ]'){
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Please Enter Valid Password"),
            );
          }
          );
        }
      }
    }
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF70a5ff),
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        title: Text('Admin Sign In', style: appBarText,),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        //scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            // width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Start with signing in"),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),

                  //Image
                  Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image(image: AssetImage('assets/images/sign_in_up/admin.png'))),

                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: TextFormField(
                    controller: _email,
                    style: TextStyle(fontSize: 20, color: Color(0xFF777878)),
                    autofillHints: [AutofillHints.email],
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'E-Mail *',
                      hintText: 'Enter Your E-Mail',
                      fillColor: Color(0xFFffffff),
                      filled: true,
                      labelStyle: TextStyle(fontSize: 16),
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.mail_outline),
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

                  TextFormField(
                    controller: _password,
                    obscureText: _obscureText,
                    autofillHints: [AutofillHints.password],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 25),
                      labelText: "Password*",
                      hintText: 'Enter Your Password*',
                      fillColor: textFormColor,
                      filled: true,
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
                        onTap: _toggle,
                        child: _obscureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
                      ),

                    ),
                  ),

                  SizedBox(height: 20,),
                  //Sign In Button
                  FlatButton(
                      color: colors,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Loader().showLoaderDialog(context);
                        setState(() {
                          SignIn();
                        });
                      },
                      child: Text("Sign In",style: buttonText,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}