import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseTypeAppModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DropDownWidget.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/UploadDocumentWidget.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class BusinessLicense extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const BusinessLicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _BusinessLicense createState() => _BusinessLicense();
}

class _BusinessLicense extends State<BusinessLicense> {
  late List<bool> isChecked = [false, false, false];
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  int val = -1, occupy_val = -1;

  List<DropDownModal> serviceList = [];
  List<DropDownModal> docTypeList = [];
  List<DropDownModal> typeList = [];

  bool draftApplication = true;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyLicenseDetails = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  final applicantNameT = TextEditingController();
  final familyNameT = TextEditingController();
  final mobileNoT = TextEditingController();
  final familyIdT = TextEditingController();
  final addressLine1T = TextEditingController();
  final addressLine2T = TextEditingController();
  final localityT = TextEditingController();
  final picodeT = TextEditingController();
  final tradeNameT = TextEditingController();
  final landAreaT = TextEditingController();
  final buildingAreaT = TextEditingController();
  final documentDecT = TextEditingController();

  final applicantNameFocusNode = FocusNode();
  final spouseNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final addressLine1FocusNode = FocusNode();
  final addressLine2FocusNode = FocusNode();
  final localityFocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  final tradeNameFocusNode = FocusNode();
  final landAreaFocusNode = FocusNode();
  final buildingAreaFocusNode = FocusNode();
  List<MstAppDocumentModel> docList = [];
  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String selected_service_type = '';
  String fileName = '';
  String filePath = '';
  String applicationId = '';
  String occupancy_selected = '';
  String serviceSelect = '';
  String docTypeSelect = '';
  String occupancy_selected_label = '';
  String selectedservice_type_label = '';
  String serviceSelect_label = '';
  String docTypeSelect_label = '';

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;

  TradeLicenseModel? licenseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
    getDropdownData();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });

      fetchApplicationData(applicationId);
    }
  }
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: () {
       //trigger leaving and use own data
       if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }

       //we need to return a future
       return Future.value(false);
     },
      child: Scaffold(
        appBar: AppBar(
          title: Text(trade_license),
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          actions: [
            //isNetCon
              //     ? IconButton(
              //   icon: Icon(
              //     Icons.wifi_outlined,
              //     color: greenColor,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // )
              //     : IconButton(
              //   icon: Icon(
              //     Icons.wifi_off_outlined,
              //     color: redColor,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // ),
            isPreviewApplication
                ? IconButton(
              icon: Icon(
                Icons.preview,
                color: whiteColor,
                size: 25,
              ),
              onPressed: () {
                openInstruction();
              },
            )
                : SizedBox(),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                  primary: globals.isTrainingMode
                      ? testModePrimaryColor
                      : primaryColor,
                )),
                child: Stepper(
                  type: stepperType,
                  physics: BouncingScrollPhysics(),
                  steps: getSteps(),
                  currentStep: _currentStep,
                  onStepTapped: (int step) {
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() => _currentStep -= 1);
                    }
                  },
                  onStepContinue: () {
                    if (_currentStep <= getSteps().length - 1) {
                      if (!globals.isTrainingMode && _currentStep == 0) {
                        saveApplicantDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 1) {
                        savePropertyDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 2) {
                        saveLicenseDetails();
                      } else if (!globals.isTrainingMode && _currentStep == 3) {
                        finalSaveApplication();
                      } else {
                        if (_currentStep < getSteps().length - 1) {
                          setState(() => _currentStep += 1);
                        } else {
                          showMessageToast(
                              'Application Draft Successfully Training Mode');
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _currentStep == 0
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: onStepCancel,
                                style: previousButtonBlueStyle,
                                child: Text(previous, style: whiteNormalText14)),
                        SizedBox(
                          width: 10,
                        ),
                        getSteps().length - 1 == _currentStep
                            ? ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child:
                                    Text(draft_or_save, style: whiteNormalText14))
                            : ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child: Text(save_next, style: whiteNormalText14)),
                      ],
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
          title: new Text('', style: formTitle),
          isActive: _currentStep >= 0,
          state: _currentStep == 0 ? StepState.editing : StepState.complete,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
        state: _currentStep == 1
            ? StepState.editing
            : _currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: licenseDetailsWidget(),
        isActive: _currentStep >= 2,
        state: _currentStep == 2
            ? StepState.editing
            : _currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
        state: _currentStep == 3
            ? StepState.editing
            : _currentStep < 3
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }

  Widget applicantDetailsWidget() {
    return Form(
      key: formKeyApplicantDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      getTranslated(
                          context, 'BusinessLicense', 'applicant_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'applicant_org_name'),
            ),
            TextFormField(
              controller: applicantNameT,
              focusNode: applicantNameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'applicant_org_name'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) {
                if (name.toString().isEmpty)
                  return 'Enter applicant name';
                else if (!onlyTextWithSpace(name!))
                  return 'Please Enter Only Text with Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                spouseNameFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'family_name'),
            ),
            TextFormField(
              controller: familyNameT,
              focusNode: spouseNameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'family_name'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (spouseName) {
                if (spouseName.toString().isEmpty)
                  return 'Enter spouse name';
                else if (!onlyTextWithSpace(spouseName!))
                  return 'Please Enter Only Text With Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                mobileNumberFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNoT,
              focusNode: mobileNumberFocusNode,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'mobile_number'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (mobileNo) {
                if (mobileNo.toString().isEmpty)
                  return 'Enter mobile number';
                else if (!mobile(mobileNo!))
                  return 'Please Enter Valid Mobile Number[Start With 6-9] ';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                familyIdFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'family_id'),
            ),
            TextFormField(
              controller: familyIdT,
              focusNode: familyIdFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'family_id'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (familyId) {
                if (familyId.toString().isEmpty)
                  return 'Enter valid family id ';
                else if (!onlyDigit(familyId!))
                  return 'Please Enter Only Number';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                addressLine1FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'address_line_1'),
            ),
            TextFormField(
              controller: addressLine1T,
              focusNode: addressLine1FocusNode,
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'address_line_1'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address1) {
                if (address1.toString().isEmpty)
                  return 'Enter address line 1';
                else if (!textareaWithoutSpecialCharacter(address1!))
                  return 'Please Enter Valid Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                addressLine2FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'address_line_2'),
            ),
            TextFormField(
              controller: addressLine2T,
              focusNode: addressLine2FocusNode,
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'address_line_2'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address2) {
                if (address2.toString().isEmpty)
                  return 'Enter address line 2';
                else if (!textareaWithoutSpecialCharacter(address2!))
                  return 'Please Enter Valid Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                pincodeFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'pincode'),
            ),
            TextFormField(
              controller: picodeT,
              focusNode: pincodeFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              maxLength: 6,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'pincode'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (pincode) {
                if (pincode.toString().isEmpty)
                  return 'Enter pincode';
                else if (!isValidPincode(pincode!))
                  return 'Please Enter Valid Pincode';
                else
                  return null;
              },
            ),
            EmptyWidget(),
            Text(
              getTranslated(
                  context, 'BusinessLicense', 'occupancy_detail'),
              style: formLabelStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Self', style: blackNormalText16),
                  dense: true,
                  leading: Radio(
                    value: 1,
                    groupValue: occupy_val,
                    onChanged: (int? value) {
                      setState(() {
                        occupy_val = value!;
                        occupancy_selected = occupy_val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text('Rented', style: blackNormalText16),
                  dense: true,
                  leading: Radio(
                    value: 2,
                    groupValue: occupy_val,
                    onChanged: (int? value) {
                      setState(() {
                        occupy_val = value!;
                        occupancy_selected = occupy_val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
                ListTile(
                  title: Text('Government', style: blackNormalText16),
                  dense: true,
                  leading: Radio(
                    value: 3,
                    groupValue: occupy_val,
                    onChanged: (int? value) {
                      setState(() {
                        occupy_val = value!;
                        occupancy_selected = occupy_val.toString();
                      });
                    },
                    activeColor: secondcolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget propertyDetailsWidget() {
    return Form(
      key: formKeyPropertyDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      getTranslated(
                          context, 'BusinessLicense', 'property_village_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            GetVillageWidget(
                selectedDistId: selectedDistId,
                selectedTalukaId: selectedTalukaId,
                selectedPanchayatId: selectedPanchayatId,
                selectedVillageId: selectedVillageId,
                selectValue: (district, taluka, panchayat, village) {
                  setState(() {
                    selectedDistId = district;
                    selectedTalukaId = taluka;
                    selectedPanchayatId = panchayat;
                    selectedVillageId = village;
                  });
                }),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  Widget licenseDetailsWidget() {
    return Form(
      key: formKeyLicenseDetails,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      getTranslated(
                          context, 'BusinessLicense', 'license_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'type'),
            ),
            DropDownWidget(
                lable: 'Select Type', // label for dropdown
                list: typeList, // list for fill dropdown
                selValue: selected_service_type, // selected value
                selectValue: (value) {
                  // function return value after dropdown selection changed
                  selected_service_type = value;
                }),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'sub_service'),
            ),
            DropDownWidget(
                lable: 'Select Sub Service', // label for dropdown
                list: serviceList, // list for fill dropdown
                selValue: serviceSelect, // selected value
                selectValue: (value) {
                  // function return value after dropdown selection changed
                  serviceSelect = value;
                }),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'trade_name'),
            ),
            TextFormField(
              controller: tradeNameT,
              focusNode: tradeNameFocusNode,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'trade_name'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (tradeName) {
                if (tradeName.toString().isEmpty)
                  return 'Enter Trade name';
                else if (!textWithOutSpace(tradeName!))
                  return 'Please Enter Only Text With No Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                landAreaFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'land_area'),
            ),
            TextFormField(
                controller: landAreaT,
                focusNode: landAreaFocusNode,
                keyboardType: TextInputType.number,
                style: blackNormalText16,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blackColor)),
                  hintText:   getTranslated(
                  context, 'BusinessLicense', 'land_area'),
                  isDense: true,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (landArea) {
                  if (landArea.toString().isEmpty)
                    return 'Enter Land Area';
                  else if (!onlyNumberWithPoint(landArea!))
                    return 'Please Enter Only Number[Point Allow]';
                  else
                    return null;
                },
                onFieldSubmitted: (String value) {
                  buildingAreaFocusNode.requestFocus();
                }),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'building_area'),
            ),
            TextFormField(
              controller: buildingAreaT,
              focusNode: buildingAreaFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'building_area'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (buildingArea) {
                if (buildingArea.toString().isEmpty)
                  return 'Enter Building Area';
                else if (!onlyNumberWithPoint(buildingArea!))
                  return 'Please Enter Only Number[Point Allow]';
                else
                  return null;
              },
            ),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  Widget uploadDocumentWidget() {
    // docList.length>0
    //     ? isPreviewApplication = true
    //     : isPreviewApplication = false;
    return Form(
      key: formKeyDoc,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color:
                  globals.isTrainingMode ? testModePrimaryColor : primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      getTranslated(
                          context, 'BusinessLicense', 'upload_document_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
                getTranslated(
                    context, 'BusinessLicense', 'doc_ty'),
            ),
            DropDownWidget(
                lable: 'Select Document Type',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'BusinessLicense', 'doc_dis'),
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:   getTranslated(
                  context, 'BusinessLicense', 'doc_dis'),
                isDense: true,
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {
              //   if (value.toString().isEmpty)
              //     return 'Enter Document Description';
              //   else if (!onlyTextWithSpace(value!))
              //     return 'Please Enter Only Text';
              //   else
              //     return null;
              // },
              onFieldSubmitted: (String value) {
                documentDecFocusNode.requestFocus();
              },
            ),
            UploadDocumentWidget(
                flag: 'P', // flag for type of document image or pdf (I,P,A)
                lable: fileName.isNotEmpty
                    ? fileName
                    : fineName + ' ( .jpg .png .jpeg )', // file name
                selectValue: (value, flag) {
                  // if flag return C it means XFile coming after capture image other wise it return  PlatformFile
                  if (flag == 'C') {
                    XFile file = value;
                    print(file.path + ',' + file.name);
                    setState(() {
                      fileName = file.name;
                      filePath = file.path;
                    });
                  } else {
                    PlatformFile file = value;
                    print(file.path! + ',' + file.name);
                    setState(() {
                      fileName = file.name;
                      filePath = file.path!;
                    });
                  }
                }),
            /*!isFileExits
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      'File not found !',
                      style: TextStyle(color: redColor, fontSize: 15),
                    ),
                  )
                : SizedBox(),*/
            EmptyWidget(),

            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    insertDocument();
                  },
                  style: squareButtonBlueStyle,
                  child: Text('Add Document', style: whiteNormalText14)),
            ),
            EmptyWidget(),
            Card(
              elevation: 5,
              child: Container(
                //height: docList.length>0 ? 150 :0,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  itemCount: docList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10,5,10,5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(docList[index].document_type)),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(filepath: docList[index].document_path, filename: docList[index].document_name)));
                                  },
                                  child: Icon(Icons.remove_red_eye),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    deleteDocument(docList[index].id.toString());
                                  },
                                  child: Icon(Icons.delete_forever),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            ),

            // isPreviewApplication
            //     ? Align(
            //         alignment: Alignment.center,
            //         child: ElevatedButton(
            //             onPressed: () {
            //               getAllDocument(applicationId);
            //               openInstruction();
            //             },
            //             style: previewButtonBlueStyle,
            //             child: Text(preview_application,
            //                 style: whiteNormalText14)))
            //     : SizedBox(),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  void saveApplicantDetails() async {
    if (formKeyApplicantDetails.currentState!.validate()) {
      if (occupy_val == -1) {
        showMessageToast('Please Select Occupancy Details');
      } else {
        TradeLicenseApplicantDetailsModel applicantDetailsModel =
            new TradeLicenseApplicantDetailsModel(
                dtl_trade_lic_id: '',
                occupancy_dtl: occupancy_selected,
                applicant_name: applicantNameT.text,
                family_id: familyIdT.text,
                family_spouse_name: familyNameT.text,
                address_line1: addressLine1T.text,
                address_line2: addressLine2T.text,
                mob_no: mobileNoT.text,
                pin_code: picodeT.text,
                crt_date: '',
                crt_user: '',
                crt_ip: '',
                lst_upd_ip: '',
                lst_upd_date: '',
                lst_upd_user: '',
                status: 'Y');

        licenseModel = new TradeLicenseModel(
            applicantDetailsModel: applicantDetailsModel,
            propertyDetailsModel: licenseModel == null
                ? null
                : licenseModel!.propertyDetailsModel,
            tradeLicenseTypeAppModel: licenseModel == null
                ? null
                : licenseModel!.tradeLicenseTypeAppModel,
            tradeLicenseDocumentDetailsModel: licenseModel == null
                ? null
                : licenseModel!.tradeLicenseDocumentDetailsModel);

        MstAddApplicationModel mstAddApplicationModel =
            new MstAddApplicationModel(
                id: applicationId.isEmpty ? null : int.parse(applicationId),
                cATEGORYID: widget.categoryId,
                sERVICEID: widget.serviceId,
                aPPLICATIONNAME: widget.title,
                service_name: widget.servieName,
                gENERATEDAPPLICATIONID: '',
                aPPLICATIONAPPLYDATE:
                    getCurrentDateUsingFormatter('dd/MM/yyyy'),
                aPPLICATIONDATA: jsonEncode(licenseModel),
                aPPLICATIONSYNCSTATUS: 'N',
                aPPLICATIONSYNCDATE: '',
                crt_user: '',
                crt_date: getCurrentDateUsingFormatter('dd/MM/yyyy'),
                lst_upd_user: '',
                lst_upd_date: applicationId.isNotEmpty
                    ? getCurrentDateUsingFormatter('dd/MM/yyyy')
                    : '',
                current_tab: _currentStep.toString(),
                from_web: '',
                draft_id: '',
                aPPVERSION: await getAppVersion());

        var i;

        if (applicationId.isNotEmpty && applicationId != '0') {
          i = await DatabaseOperation.instance.updateMstAddApplicationModel(
              applicationId,
              jsonEncode(licenseModel),
              getCurrentDateUsingFormatter('DD/MM/YYYY'),
              _currentStep.toString());
        } else {
          i = await DatabaseOperation.instance
              .insertMstAddApplicationModel(mstAddApplicationModel);
        }

        if (i > 0) {
          setState(() {
            applicationId = i.toString();
          });
          showMessageToast('Applicant details draft');
          if (_currentStep < getSteps().length) {
            setState(() => _currentStep += 1);
          }
        } else {
          showMessageToast('Something went wrong !');
        }
      }
    }
  }

  Future<void> savePropertyDetails() async {
    if (formKeyPropertyDetails.currentState!.validate()) {
      TradeLicensePropertyDetailsModel licensePropertyDetailsModel =
          new TradeLicensePropertyDetailsModel(
              dtl_trade_lic_prop_id: '',
              district_id: selectedDistId,
              tp_id: selectedTalukaId,
              gp_id: selectedPanchayatId,
              village_id: selectedVillageId,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: "Y");

      licenseModel = new TradeLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licensePropertyDetailsModel,
          tradeLicenseTypeAppModel: licenseModel!.tradeLicenseTypeAppModel,
          tradeLicenseDocumentDetailsModel:
              licenseModel!.tradeLicenseDocumentDetailsModel);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(licenseModel),
          getCurrentDateUsingFormatter('DD/MM/YYYY'),
          _currentStep.toString());

      if (i > 0) {
        showMessageToast('Property/Village details draft');
        if (_currentStep < getSteps().length) {
          setState(() => _currentStep += 1);
        }
      } else {
        showMessageToast('Something went wrong !');
      }
    }
  }

  Future<void> saveLicenseDetails() async {
    if (formKeyLicenseDetails.currentState!.validate()) {
      TradeLicenseTypeAppModel programdetailsModel =
          new TradeLicenseTypeAppModel(
              dtl_trade_lic_type_id: '',
              lic_service_type_id: selected_service_type,
              sub_service_type: serviceSelect,
              trade_name: tradeNameT.text,
              land_area_sq_meet: landAreaT.text,
              building_area_sq_meet: buildingAreaT.text,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new TradeLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licenseModel!.propertyDetailsModel,
          tradeLicenseTypeAppModel: programdetailsModel,
          tradeLicenseDocumentDetailsModel:
              licenseModel!.tradeLicenseDocumentDetailsModel);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(licenseModel),
          getCurrentDateUsingFormatter('DD/MM/YYYY'),
          _currentStep.toString());

      if (i > 0) {
        showMessageToast('Business License details draft');
        if (_currentStep < getSteps().length) {
          setState(() => _currentStep += 1);
        }
      } else {
        showMessageToast('Something went wrong !');
      }
    }
  }

  void saveDocumentDetails(String flag) async {
   // if (filePath.isNotEmpty) {
      TradeLicenseDocumentDetailsModel documentDetailsModel =
          new TradeLicenseDocumentDetailsModel(
              dtl_trade_lic_doc_id: '',
              doc_id: filePath,
              doc_description: documentDecT.text,
              doc_name: '',
              doc_thumbnail_image: '',
              doc_type_id: docTypeSelect,
              folder_name: '',
              is_used: '',
              sub_folder_name: '',
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new TradeLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licenseModel!.propertyDetailsModel,
          tradeLicenseTypeAppModel: licenseModel!.tradeLicenseTypeAppModel,
          tradeLicenseDocumentDetailsModel: documentDetailsModel);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(licenseModel),
          getCurrentDateUsingFormatter('DD/MM/YYYY'),
          _currentStep.toString());

      if (i > 0) {
        if (flag == 'save') {
          var j = await DatabaseOperation.instance
              .updateFinalApplicationStatus(applicationId);
          await DatabaseOperation.instance
              .updateSyncMessageStatus(applicationId, '');
          if (j > 0) {
            showMessageToast('Application Submit Successfully');
          }
        } else {
          showMessageToast('Document details draft');
        }

        Navigator.pop(context);
      } else {
        showMessageToast('Something went wrong !');
      }
   // }
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      licenseModel = new TradeLicenseModel(
          applicantDetailsModel:
              jsonData.containsKey('1') && jsonData["1"] != null
                  ? TradeLicenseApplicantDetailsModel.fromJson(jsonData["1"])
                  : null,
          propertyDetailsModel:
              jsonData.containsKey('2') && jsonData["2"] != null
                  ? TradeLicensePropertyDetailsModel.fromJson(jsonData["2"])
                  : null,
          tradeLicenseTypeAppModel:
              jsonData.containsKey('3') && jsonData["3"] != null
                  ? TradeLicenseTypeAppModel.fromJson(jsonData["3"])
                  : null,
          tradeLicenseDocumentDetailsModel:
              jsonData.containsKey('4') && jsonData["4"] != null
                  ? TradeLicenseDocumentDetailsModel.fromJson(jsonData["4"])
                  : null);

      if (licenseModel!.applicantDetailsModel != null) {
        applicantNameT.text =
            licenseModel!.applicantDetailsModel!.applicant_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.family_id;
        familyNameT.text =
            licenseModel!.applicantDetailsModel!.family_spouse_name;
        addressLine1T.text = licenseModel!.applicantDetailsModel!.address_line1;
        addressLine2T.text = licenseModel!.applicantDetailsModel!.address_line2;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mob_no;
        picodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
        occupy_val =
            int.parse(licenseModel!.applicantDetailsModel!.occupancy_dtl);

        occupancy_selected = licenseModel!.applicantDetailsModel!.occupancy_dtl;
      }
      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gp_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;

        districtName =
            await DatabaseOperation.instance.getDistrictName(selectedDistId);
        talukaName =
            await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(selectedPanchayatId);
        villageName =
            await DatabaseOperation.instance.getVillageName(selectedVillageId);
      }

      if (licenseModel!.tradeLicenseTypeAppModel != null) {
        selected_service_type =licenseModel!.tradeLicenseTypeAppModel!.lic_service_type_id;
        serviceSelect =
            licenseModel!.tradeLicenseTypeAppModel!.sub_service_type;
        tradeNameT.text = licenseModel!.tradeLicenseTypeAppModel!.trade_name;
        landAreaT.text =
            licenseModel!.tradeLicenseTypeAppModel!.land_area_sq_meet;
        buildingAreaT.text =
            licenseModel!.tradeLicenseTypeAppModel!.building_area_sq_meet;
      }

     /* if (licenseModel!.tradeLicenseDocumentDetailsModel != null) {
        filePath = licenseModel!.tradeLicenseDocumentDetailsModel!.doc_id;
        var fname =
            licenseModel!.tradeLicenseDocumentDetailsModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
        docTypeSelect = licenseModel!.tradeLicenseDocumentDetailsModel!.doc_type_id;
        documentDecT.text =
            licenseModel!.tradeLicenseDocumentDetailsModel!.doc_description;
      }*/
      if (_currentStep < getSteps().length - 1) {
        if (int.parse(model.current_tab) == getSteps().length - 1) {
          _currentStep = getSteps().length - 1;

        } else {
          _currentStep = int.parse(model.current_tab) + 1;
        }
      }
      if(_currentStep == 3){
        isFileExits = false;
        getAllDocument(applicationId);
      }
      isPreviewApplication = true;
      setState(() {});
    }
  }

  void getConnectivity() {
    Connectivity().checkConnectivity().then((value) => {
          if (value == ConnectivityResult.mobile ||
              value == ConnectivityResult.wifi)
            {setState(() => isNetCon = true)}
          else
            {setState(() => isNetCon = false)}
        });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
          setState(() => isNetCon = true);
          break;
        case ConnectivityResult.wifi:
          setState(() => isNetCon = true);
          break;
        case ConnectivityResult.none:
        default:
          setState(() => isNetCon = false);
      }
    });
  }

  Future<void> openInstruction() async {
    if (occupy_val == 1) {
      occupancy_selected_label = 'Self';
    } else if (occupy_val == 2) {
      occupancy_selected_label = 'Rented';
    } else if (occupy_val == 3) {
      occupancy_selected_label = 'Government';
    }

    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId);
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
    panchayatName = await DatabaseOperation.instance
        .getPanchayatName(selectedPanchayatId);
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId);
    selectedservice_type_label = await DatabaseOperation.instance.getDropdownName("getMSTTradeTypeData",selected_service_type);
    serviceSelect_label=  await DatabaseOperation.instance.getDropdownName("getMSTTradeSubTypeData",serviceSelect);
    docTypeSelect_label = await DatabaseOperation.instance.getDropdownName("getMstDocData",docTypeSelect);

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            insetPadding: EdgeInsets.all(20),
            backgroundColor: whiteColor,
            elevation: 5,
            actions: [
              Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: cancelButtonBlueStyle,
                      child: Text(ok, style: whiteNormalText14))),
            ],
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  //height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            preview_application,
                            style: blackBoldText16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            // collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey1,

                            collapsedIconColor: whiteColor,
                            title: Text(
                                getTranslated(
                                    context, 'BusinessLicense', 'applicant_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', ''),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      occupancy_selected_label,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'applicant_org_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicantNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'family_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNoT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      addressLine1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      addressLine2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'pincode'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      picodeT.text,
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey1);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            //collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey2,

                            collapsedIconColor: whiteColor,
                            title: Text(
                                getTranslated(
                                    context, 'BusinessLicense', 'property_village_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'district'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      districtName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'taluka'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      talukaName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'panchayat'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      panchayatName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Building_License', 'village'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      villageName,
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey2);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            // collapsedBackgroundColor: primaryColor,
                            // backgroundColor: primaryColor,
                            key: expansionTileKey3,

                            collapsedIconColor: whiteColor,
                            title: Text(
                                getTranslated(
                                    context, 'BusinessLicense', 'license_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
                                //padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'type'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                        selectedservice_type_label,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'sub_service'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                     serviceSelect_label,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'trade_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      tradeNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'land_area'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      landAreaT.text+" Sq mt",
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'BusinessLicense', 'building_area'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      buildingAreaT.text+" Sq mt",
                                      style: grayBoldText16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey3);
                              }
                            },
                          ),
                        ),
                        EmptyWidget(),
                        Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ExpansionTile(
                            key: expansionTileKey4,
                            collapsedIconColor: whiteColor,
                            title: Text(
                                getTranslated(
                                    context, 'BusinessLicense', 'upload_document_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                  width: double.infinity,
                                  decoration: previewBoxDecoration,
                                  padding: previewContainerPadding,
                                  //padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          //height: docList.length>0 ? 150 :0,
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              primary: true,
                                              itemCount: docList.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(10,5,10,5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(child: Text(docList[index].document_type)),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(filepath: docList[index].document_path, filename: docList[index].document_name)));
                                                              },
                                                              child: Icon(Icons.remove_red_eye),
                                                            ),
                                                            // SizedBox(width: 10,),
                                                            // GestureDetector(
                                                            //   onTap: (){
                                                            //     deleteDocument(docList[index].id.toString());
                                                            //   },
                                                            //   child: Icon(Icons.delete_forever),
                                                            // )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),


                                   /*   Text(
                                        doc_ty,
                                        style: graypreviewText13,
                                      ),
                                      Text(
                                        docTypeSelect_label,
                                        style: grayBoldText16,
                                      ),
                                      Divider(thickness: 1),
                                      Text(
                                        doc_dis,
                                        style: graypreviewText13,
                                      ),
                                      Text(
                                        documentDecT.text,
                                        style: grayBoldText16,
                                      ),
                                      Divider(thickness: 1),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (filePath.isNotEmpty) {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewImage(
                                                                filepath:
                                                                    filePath,
                                                                filename:
                                                                    fileName)));
                                              } else {
                                                showMessageToast(
                                                    'No Image to display');
                                              }
                                            },
                                            icon: Icon(
                                              fileName.contains('pdf')
                                                  ? Icons.picture_as_pdf
                                                  : Icons.image,
                                              size: 35,
                                              color: whiteColor,
                                            ),
                                            label: Text(fileName,
                                                style: whiteBoldText14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  )),
                            ],
                            onExpansionChanged: (bool value) {
                              if (value) {
                                _scrollToSelectedContent(
                                    expansionTileKey: expansionTileKey4);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  void finalSaveApplication() {
    // set up the button
    Widget okButton = TextButton(
      child: Text('Draft Application'),
      onPressed: () {
        saveDocumentDetails('draft');
        if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }
       // Navigator.pop(context);
      },
    );

    Widget okButton2 = TextButton(
      child: Text('Save Application'),
      onPressed: () async {
        if(docList.isEmpty){
          Navigator.pop(context);
          showMessageToast('Please upload document');
        }else{
          saveDocumentDetails('save');
          if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
            Navigator.pop(context);
          } else {
            Navigator.of(context)
              ..pop()
              ..pop();
          }
         // Navigator.pop(context);
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Draft/Save"),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("Are you want to draft or save application ?"),
            Divider(
              thickness: 1,
            ),
            Text(
              "* After save application you can't update application",
              style: TextStyle(color: redColor),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
        okButton2,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getDropdownData() async {
    docTypeList =
        await DatabaseOperation.instance.getDropdown("getMstDocData", "3", "9");

    typeList = await DatabaseOperation.instance.getDropdown("getMSTTradeTypeData", "3", "9");
    serviceList = await DatabaseOperation.instance
        .getDropdown("getMSTTradeSubTypeData", "3", "9");
  }


  void insertDocument() async {

    if (docTypeSelect.isEmpty){
      showMessageToast('Please select document type');
    }else if (filePath.isEmpty || fileName.isEmpty){
      showMessageToast('Please choose file !');
    } else if(applicationId.isEmpty || applicationId == '0'){
      showMessageToast('Application id not found !');
    } else{
      MstAppDocumentModel model = new MstAppDocumentModel(
          id: null,
          document_id: docTypeSelect,
          document_type: await DatabaseOperation.instance.getDropdownNameUsingCategory(widget.categoryId,widget.serviceId,"getMstDocData", docTypeSelect),
          document_description: documentDecT.text,
          document_name: fileName,
          document_path: filePath,
          app_trn_id: applicationId,
          sync_status: "N");

      int i = await DatabaseOperation.instance.insertDocument(model);

      if(i > 0){
        showMessageToast('Document inserted successfully');
        formKeyDoc.currentState!.reset();
        docTypeSelect = '';
        documentDecT.text = '';
        filePath = '';
        fileName = '';
        setState(() { });
        getAllDocument(applicationId);
      }else{
        showMessageToast('Not able to insert document');
      }

    }
  }

  void getAllDocument(String id) async {

    docList = await DatabaseOperation.instance.getAllDocument(id);

    setState(() {});
  }

  void deleteDocument(String id) {
    // set up the button
    Widget okButton = TextButton(
      child: Text('Delete'),
      onPressed: () async {
        print(id);
        int i = await DatabaseOperation.instance.deleteDocument(id);
        if(i>0){
          Navigator.pop(context);
          getAllDocument(applicationId);
        }
      },
    );

    Widget okButton2 = TextButton(
      child: Text('No'),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Document"),
      content: Text("Are you want to delete document ?"),
      actions: [
        okButton,
        okButton2,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
