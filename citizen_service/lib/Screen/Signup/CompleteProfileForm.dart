import 'dart:convert';

import 'package:citizen_service/Screen/OTPScreen/otp_screen.dart';
import 'package:citizen_service/Utility/GenralButton.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CompleteProfileForm extends StatefulWidget {
  String data1;
   CompleteProfileForm({Key? key,required this.data1}) : super(key: key);
   
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final pass_ = TextEditingController();
  final cPass_ = TextEditingController();

  final passF =  FocusNode();
  final cPassF = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextCPassword = true;

  var mEP = {};

  @override
  void initState() {
    super.initState();
    mEP = jsonDecode(widget.data1);
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft,child: Text('Password must contain One Capital Char, One digit, One Special Char (@,#,,&,*..etc) and 8 or more than 8 Char')),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(50)),
          DefaultButton(
            text: "Verify",
            press: () {
              if(_formKey.currentState!.validate()){
                mEP["password"]  = pass_.text;
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => OtpScreen(data: jsonEncode(mEP))));
                sendOtp(mEP);
                print(jsonEncode(mEP));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: _obscureTextCPassword,
      controller: cPass_,
      validator: (pass) {
        if (pass.toString().isEmpty)
          return 'Enter Confirm Password';
        else if (pass_.text != pass)
          return 'Password Must Be Same';
        else
          return null;
      },
      focusNode: cPassF,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              _obscureTextCPassword = !   _obscureTextCPassword;
            });
          },
          child: Icon(
            _obscureTextCPassword
                ? Icons.visibility
                : Icons.visibility_off,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureTextPassword,
      controller: pass_,
      focusNode: passF,
      validator: (pass) {
        if (pass.toString().isEmpty)
          return 'Enter Password';
        else if (!password(pass!))
          return 'Please Enter Valid Password';
        else
          return null;
      },
      onFieldSubmitted: (String value) {
        cPassF.requestFocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              _obscureTextPassword = !_obscureTextPassword;
            });
          },
          child: Icon(
            _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  void sendOtp(Map mEP) {

  }
}
