import 'package:e_commerce/UI/SIGNING/information.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP_Verification extends StatefulWidget {
  String _email;
  OTP_Verification(this._email);
  @override
  _OTP_VerificationState createState() => _OTP_VerificationState(this._email);
}

class _OTP_VerificationState extends State<OTP_Verification> {
  String _email;
  _OTP_VerificationState(this._email);

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _pinFocus = FocusNode();

  void verifyOTP()async{
    var res = EmailAuth.validate(receiverMail: _email, userOTP: _otpController.text);
    if(res){
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Information(_email)));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Information(_email)), (route) => false);
    }else{
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Invalid OTP"),
          content:
               Text("Please Type Valid OTP"),
        );
      }
      );
    }
  }

  BoxDecoration pinOtpDecoration = BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
          color: Colors.grey
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: PinPut(
                fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25, color: Colors.white),
              eachFieldWidth: 40.0,
                eachFieldHeight: 50.0,
              focusNode: _pinFocus,
              controller: _otpController,
              submittedFieldDecoration: pinOtpDecoration,
              selectedFieldDecoration: pinOtpDecoration,
              followingFieldDecoration: pinOtpDecoration,
              pinAnimationType: PinAnimationType.rotation,
              autovalidateMode: AutovalidateMode.always,
              onSubmit: (otp)async{
                  verifyOTP();
              },
            )
          ),

        ],
      ),

    );
  }
}
