import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DatePicker.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mutation extends StatefulWidget {
  @override
  _MutationState createState() => _MutationState();
}

class _MutationState extends State<Mutation> {
  var _radioValue = "one";
  bool checkedValue = false;
  DateTime date = DateTime.now();
  String r_date = "mm/dd/yy";
  bool draftApplication = true;

  final search_ = TextEditingController();
  final reg_number = TextEditingController();
  final reg_amount = TextEditingController();
  final applicant_name_ = TextEditingController();
  final address_ = TextEditingController();
  final email_ = TextEditingController();
  final mobile_ = TextEditingController();
  final fees_ = TextEditingController();
  final receipt_no_ = TextEditingController();
  final property_id_search = TextEditingController();
  final property_id_ = TextEditingController();

  final searchFocusNode = FocusNode();
  final reg_numberFocusNode = FocusNode();
  final reg_amountFocusNode = FocusNode();
  final applicant_nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final email_FocusNode = FocusNode();
  final mobile_FocusNode = FocusNode();
  final fees_FocusNode = FocusNode();
  final receipt_no_FocusNode = FocusNode();
  final property_id_FocusNode = FocusNode();
  final property_FocusNode = FocusNode();

  final formKeyApplicantDetails = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: whiteColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(mutation),
          backgroundColor: primaryColor,
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 10),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 6),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKeyApplicantDetails,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        elevation: 3.0,
                        child: Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              applicant_details.toUpperCase(),
                              style: whiteBoldText16,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: searchFocusNode,
                          controller: search_,
                          style: blackNormalText16,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            hintText: search_property_id_drop,
                          ),
                          validator: (name) {
                            if (name.toString().isNotEmpty)
                              return null;
                            else
                              return 'Enter property id';
                          },
                          onFieldSubmitted: (String value) {
                            reg_numberFocusNode.requestFocus();
                          },
                        ),
                      ),
                      EmptyWidget(),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: downloadButtonBlueStyle,
                          onPressed: () {},
                          child: Text(
                            search.toUpperCase(),
                            style: whiteNormalText16,
                          ),
                        ),
                      ),
                      EmptyWidget(),
                      EmptyWidget(),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          applicant_details,
                          style: grayNormalText16,
                        ),
                      ),
                      EmptyWidget(),
                      EmptyWidget(),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 'one',
                            groupValue: _radioValue,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _radioValue = value.toString();
                              });
                            },
                          ),
                          Text(
                            registered,
                            style: blackBoldText14,
                          ),
                        ],
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: reg_number,
                        focusNode: reg_numberFocusNode,
                        keyboardType: TextInputType.number,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: registration_no,
                        ),
                        validator: (value) {
                          if (value.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter  registration number ';
                        },
                        onFieldSubmitted: (String value) {
                          reg_amountFocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      Text(
                        registration_date,
                        style: grayNormalText14,
                      ),
                      EmptyWidget(),
                      DateChoser(date, (value) {
                        setState(() {
                          r_date = value.toString();
                        });
                      }, r_date),
                      EmptyWidget(),
                      TextFormField(
                        controller: reg_amount,
                        focusNode: reg_amountFocusNode,
                        keyboardType: TextInputType.number,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: registered_amount,
                        ),
                        validator: (value) {
                          if (value.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter registered amount';
                        },
                        onFieldSubmitted: (String value) {
                          applicant_nameFocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: applicant_name_,
                        focusNode: applicant_nameFocusNode,
                        keyboardType: TextInputType.text,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: applicant_name,
                        ),
                        validator: (value) {
                          if (value.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter applicant name';
                        },
                        onFieldSubmitted: (String value) {
                          addressFocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        minLines: 3,
                        focusNode: addressFocusNode,
                        maxLines: null,
                        controller: address_,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: address,
                        ),
                        validator: (address) {
                          if (address.toString().isNotEmpty)
                            return null;
                          else
                            return 'Enter address ';
                        },
                        onFieldSubmitted: (String value) {
                          email_FocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: email_,
                        focusNode: email_FocusNode,
                        keyboardType: TextInputType.emailAddress,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor


                              )),
                          hintText: email_id,
                        ),
                        validator: (email) {
                          if (email.toString().isEmpty)
                            return 'Enter email ID';
                          else if (!validEmail(email!)) {
                            return 'Enter valid email ID';
                          } else
                            return null;
                        },
                        onFieldSubmitted: (String value) {
                          mobile_FocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: mobile_,
                        focusNode: mobile_FocusNode,
                        keyboardType: TextInputType.phone,
                        style: blackNormalText16,
                        maxLength: 10,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: mobile_number,
                        ),
                        validator: (mobileNo) {
                          if (mobileNo.toString().isEmpty)
                            return 'Enter mobile number';
                          else if (mobileNo!.length != 10)
                            return 'Enter valid mobile number';
                          else
                            return null;
                        },
                      ),
                      EmptyWidget(),
                      Text(
                        documents_required,
                        style: grayNormalText14,
                      ),
                      EmptyWidget(),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: blackColor,
                            value: checkedValue,
                            onChanged: (bool? value) {
                              setState(() {
                                checkedValue = value!;
                              });
                            },
                          ),
                          Text(cryptocurrency),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      EmptyWidget(),
                      Text(
                        fee_details,
                        style: grayNormalText14,
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: fees_,
                        focusNode: fees_FocusNode,
                        keyboardType: TextInputType.number,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: fee,
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty)
                            return 'Enter fees';
                          else
                            return null;
                        },
                        onFieldSubmitted: (String value) {
                          receipt_no_FocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: receipt_no_,
                        focusNode: receipt_no_FocusNode,
                        keyboardType: TextInputType.number,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: receipt_no,
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty)
                            return 'Enter receipt no';
                          else
                            return null;
                        },
                        onFieldSubmitted: (String value) {
                          property_FocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      EmptyWidget(),
                      Text(
                        for_transaction,
                        style: grayNormalText14,
                      ),
                      EmptyWidget(),
                      TextFormField(
                        controller: property_id_,
                        focusNode: property_FocusNode,
                        keyboardType: TextInputType.number,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: property_id,
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty)
                            return 'Enter property  id';
                          else
                            return null;
                        },
                      ),
                      EmptyWidget(),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: downloadButtonBlueStyle,
                          onPressed: () {},
                          child: Text(
                            add_more.toUpperCase(),
                            style: whiteNormalText16,
                          ),
                        ),
                      ),
                      EmptyWidget(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: downloadButtonBlueStyle,
                          onPressed: () {
                            submitApplication();
                          },
                          child: Text(
                            submit.toUpperCase(),
                            style: whiteNormalText16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  void submitApplication() {
    var jsonData = {
      'search_': search_.text,
      'reg_number': reg_number.text,
      'applicant_name': applicant_name_.text,
      'address': address_.text,
      'email_': email_.text,
      'mobile_': mobile_.text,
      'fees_': fees_.text,
      'receipt_no_': receipt_no_.text,
      'property_id_': property_id_.text,
    };

    if (formKeyApplicantDetails.currentState!.validate()) {
      print(jsonData);
      showMessageToast('Applicant details uploaded');
    }
  }
}
