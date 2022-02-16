import 'package:e_commerce/E-Com/admin_sign_in.dart';
import 'package:e_commerce/UI/SIGNING/sign_up.dart';
import 'package:e_commerce/UI/body.dart';
import 'package:e_commerce/configs.dart';
import 'package:e_commerce/loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign_in extends StatefulWidget {
  @override
  _Sign_inState createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {

  var _email = TextEditingController();
  var _password = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> SignIn() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email.text, password: _password.text);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Body()), (route) => false);

      } catch (e) {
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

        if(e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.' ||
            e.message == 'Ignoring header X-Firebase-Locale because its value was null.'){
          showDialog(context: context, builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Please Enter Valid E-Mail"),
            );
          }
          );
        }
        print(e.message);
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
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: colors,
        title: Text(
            "User Login",
            style: buttonText,
          ),
        centerTitle: true,
        actions: [
          FlatButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Sign_In()));
          }, child: Text('An Admin'))
        ],
      ),
      body: Container(
      padding: EdgeInsets.only(left: 25, right: 25),
        child: Form(
        key: _formkey,
        //scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //Image
                  Image(image: AssetImage('assets/images/sign_in_up/sign_in1.png'), height: 200,),

                  //E-Mail
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      cursorHeight: 25,
                      autofillHints: [AutofillHints.email],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 25),
                        fillColor: textFormColor,
                        filled: true,
                        labelText: "E-Mail",
                        hintText: 'Please Enter Your E-Mail',
                        prefixIcon: Icon(Icons.email_outlined),
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
                      // validator: (input) {
                      //   if (input.isEmpty) {
                      //     return "Please Enter Your Email";
                      //   }
                      //   return null;
                      // },
                    ),),

                  //Password
                  TextFormField(
                    controller: _password,
                    obscureText: _obscureText,
                    autofillHints: [AutofillHints.password],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 25),
                        labelText: "Password",
                        hintText: 'Enter Your Password',
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

                  //Login
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: FlatButton(
                      color: colors,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Loader().showLoaderDialog(context);
                        setState(() {
                          SignIn();
                          if(_email.text.isEmpty){
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Please Enter an Email"),
                              );});
                          }
                          else if(_password.text.isEmpty){
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Please Enter an Password"),
                              );});
                          }

                        });
                      },
                      child: Text("Sign In",style: buttonText,)),),

                  //Text
                  Text("Don't have an Account?"),

                  //Sign up
                  FlatButton(
                      color: colors,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sign_up()));
                      },
                      child: Text("Sign Up",style: buttonText,))
                ],
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}
