

import 'dart:convert';

import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/themeData.dart';
import 'package:citizen_service/Utility/GenralButton.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/screensize.dart';
import 'package:flutter/material.dart';

import 'CompleteProfileForm.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _phone = TextEditingController();

  final _fName = TextEditingController();
  final _lName = TextEditingController();
  final _dob = TextEditingController();
  final _address1 = TextEditingController();
  final _address2 = TextEditingController();

  final emailF = FocusNode();
  final phoneF = FocusNode();
  final fNameF = FocusNode();
  final lNameF = FocusNode();
  final doB = FocusNode();
  final address1 = FocusNode();
  final address2 = FocusNode();


  String data1 = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBirthDateFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressLine1FormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressLine2FormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          //
          // buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                var jsonData = {
                  "first_name": _fName.text,
                  "last_name": _lName.text,
                  "dob": _dob.text,
                  "mobile_no": _phone.text,
                  "email_id": _email.text,
                  "address1": _address1.text,
                  "address2": _address2.text
                };
                data1 = jsonEncode(jsonData);
                showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  transitionDuration: Duration(milliseconds: 1000),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SafeArea(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: completeProfile(context),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      validator: (email) {
        if (email.toString().isEmpty)
          return 'Enter email ID';
        else if (!validEmail(email!))
          return 'Enter valid email ID';
        else
          return null;
      },
      focusNode: emailF,
      onFieldSubmitted: (String value) {
        address1.requestFocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
       floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:Icon(Icons.email),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
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
      focusNode: phoneF,
      onFieldSubmitted: (String value) {
        emailF.requestFocus();
      },
      maxLength: 10,
      decoration: InputDecoration(
          labelText: "Mobile",
          hintText: "Enter your phone number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone)),
    );
  }


  TextFormField buildLastNameFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) {
        if (name.toString().isEmpty)
          return 'Enter last name';
        else if (!simpleText(name!))
          return 'Please Enter Only Text';
        else
          return null;
      },
      focusNode: lNameF,
      onFieldSubmitted: (String value) {
         // mNameF.requestFocus();
      },
      controller: _lName,
      decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Last name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:Icon(Icons.person)
      ),
    );
  }

  TextFormField buildBirthDateFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) {
        if (name.toString().isEmpty)
          return 'Enter date of birth';
        // else if (!simpleText(name!))
        //   return 'Please Enter Only Text';
        else
          return null;
      },
      focusNode: doB,
      readOnly: true,
      onFieldSubmitted: (String value) {
        // mNameF.requestFocus();
      },
      onTap: () async {
        var date = await selectDobDate(context, DateTime.now(),false);
        _dob.text = date != null ? date : '';
      },
      controller: _dob,
      decoration: InputDecoration(
          labelText: "Date Of Birth",
          hintText: "DD/MM/YYYY",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:Icon(Icons.date_range)
      ),
    );
  }

  TextFormField buildAddressLine1FormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) {
        if (name.toString().isEmpty)
          return 'Enter address line 1';
        else if (!simpleText(name!))
          return 'Please Enter Only Text';
        else
          return null;
      },
      focusNode: address1,
      onFieldSubmitted: (String value) {
        address2.requestFocus();
      },
      controller: _address1,
      decoration: InputDecoration(
          labelText: "Address Line 1",
          hintText: "Address 1",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:Icon(Icons.home)
      ),
    );
  }

  TextFormField buildAddressLine2FormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) {
        if (name.toString().isEmpty)
          return 'Enter address line 2';
        else if (!simpleText(name!))
          return 'Please Enter Only Text';
        else
          return null;
      },
      focusNode: address2,
      onFieldSubmitted: (String value) {
        // mNameF.requestFocus();
      },
      controller: _address2,
      decoration: InputDecoration(
          labelText: "Address Line 2",
          hintText: "Address 2",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:Icon(Icons.home)
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) {
        if (name.toString().isEmpty)
          return 'Enter first name';
        else if (!simpleText(name!))
          return 'Please Enter Only Text';
        else
          return null;
      },
      focusNode: fNameF,
      onFieldSubmitted: (String value) {
        lNameF.requestFocus();
      },
      controller: _fName,
      decoration: InputDecoration(
          labelText: "First Name",
          hintText: "First name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:Icon(Icons.person)
      ),
    );
  }

  Widget completeProfile(BuildContext context){
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Theme(
              data: theme(),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: (){
                             Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text("Password Confirmation", style: headingStyle),
                        Text("Complete your details or continue  \nwith Bapuji Seva Kendra",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.06),
                        CompleteProfileForm( data1: data1,),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        // Text(
                        //   "By continuing your confirm that you agree \nwith our Term and Condition",
                        //   textAlign: TextAlign.center,
                        //   style: Theme.of(context).textTheme.caption,
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
