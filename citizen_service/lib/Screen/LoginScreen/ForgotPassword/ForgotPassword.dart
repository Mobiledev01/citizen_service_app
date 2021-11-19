import 'dart:convert';

import 'package:citizen_service/Screen/OTPScreen/otp_screen.dart';
import 'package:citizen_service/Screen/Signup/signUp.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/GenralButton.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:citizen_service/Utility/themeData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Theme(
            data: theme(),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back))),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(28),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Please enter your mobile number and we will send \nyou a otp to return to your account",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.1),
                      forgotPassForm(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotPassForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.phone,
              validator: (mobileNo) {
                if (mobileNo.toString().isEmpty)
                  return 'Enter mobile number';
                else if (!mobile(mobileNo!))
                  return 'Please Enter Valid Mobile Number';
                else
                  return null;
              },
              controller: _phone,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Mobile number",
                  hintText: "Enter registered mobile number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.phone)),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "Send Otp",
              press: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(data: jsonEncode({}))));
                }
              },
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account? ",
                  style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: redColor),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
