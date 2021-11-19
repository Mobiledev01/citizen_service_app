import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicenseProgramDetailsModel.dart';
import 'package:citizen_service/Model/EntertainmentLicenseModel/EntmtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
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

class Entertainmentlicense extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const Entertainmentlicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _Entertainmentlicense createState() => _Entertainmentlicense();
}

class _Entertainmentlicense extends State<Entertainmentlicense> {
  final FocusNode focusNodeMobileNo = FocusNode();
  StepperType stepperType = StepperType.horizontal;
  int _currentStep = 0;

  List<DropDownModal> propertyList = [
    DropDownModal(id: '1', title: 'Property', titleKn: ''),
  ];

  List<DropDownModal> entertainment_list = [];
  List<MstAppDocumentModel> docList = [];

  List<DropDownModal> docTypeList = [];
  String selectedProperty = '', entertainment_select = '';
  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String applicationId = '';
  String entmtPlace = '';
  String fileName = '';
  String filePath = '';
  String selected_place = '';
  String checkbox_value = '';
  String docTypeSelect = '';
  String docTypeSelect_Label = '';
  String entertainment_select_label = '';

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  List<bool> isChecked = [false, false];
  bool _radioValue = false;
  bool isNetCon = false;
  bool isPreviewApplication = false;

  int val = -1;

  bool draftApplication = true;
  bool isFileExits = true;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyEntertainmentProgramme = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  final nameT = TextEditingController();
  final parentNameT = TextEditingController();
  final familyIdT = TextEditingController();
  final address1T = TextEditingController();
  final address2T = TextEditingController();
  final mobileNoT = TextEditingController();
  final pincodeT = TextEditingController();
  final documentDecT = TextEditingController();

  final nameFocusNode = FocusNode();
  final parentNameFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final mobileNoFocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  EntmtLicenseModel? licenseModel;

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
          title: Text(entertainment_title),
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
                        saveEntertainmentProgramme();
                      } else if (!globals.isTrainingMode && _currentStep == 3) {
                        finalSaveApplication();
                      } else {
                        if (_currentStep < getSteps().length - 1) {
                          setState(() => _currentStep += 1);
                        } else {
                          showMessageToast('Application Draft Successfully Training Mode');
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
                                child: Text(draft_or_save, style: whiteNormalText14))
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
        content: entertainmentProgrammeWidget(),
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
                    getTranslated(context, 'Entertainmentlicense',
                            'applicant_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'applicant_name'),
            ),
            TextFormField(
              controller: nameT,
              focusNode: nameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'Entertainmentlicense', 'applicant_name'),
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
                parentNameFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'parent_nm'),
            ),
            TextFormField(
              controller: parentNameT,
              focusNode: parentNameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'Entertainmentlicense', 'parent_nm'),
                isDense: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (spouseName) {
                if (spouseName.toString().isEmpty)
                  return 'Enter Parent/Spouse name';
                else if (!onlyTextWithSpace(spouseName!))
                  return 'Please Enter Only Text With Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                familyIdFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Entertainmentlicense', 'family_id'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: familyIdT,
              focusNode: familyIdFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'Entertainmentlicense', 'family_id'),
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
                address1FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'address_line_1'),
            ),
            TextFormField(
              controller: address1T,
              focusNode: address1FocusNode,
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'Entertainmentlicense', 'address_line_1'),
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
                address2FocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'address_line_2'),
            ),
            TextFormField(
              controller: address2T,
              focusNode: address2FocusNode,
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'Entertainmentlicense', 'address_line_2'),
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
                mobileNoFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNoT,
              focusNode: mobileNoFocusNode,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: getTranslated(
                    context, 'Entertainmentlicense', 'mobile_number'),
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
                pincodeFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'pincode'),),
            TextFormField(
              controller: pincodeT,
              focusNode: pincodeFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              maxLength: 6,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'Entertainmentlicense', 'pincode'),
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
                    getTranslated(context, 'Entertainmentlicense',
                            'property_village_details')
                        .toUpperCase(),
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
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'property'),
            ),
            DropDownWidget(
                lable: 'Select Property', // label for dropdown
                list: propertyList, // list for fill dropdown
                selValue: selectedProperty,
                // selected value
                selectValue: (value) {
                  setState(() {
                    selectedProperty = value;
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget entertainmentProgrammeWidget() {
    return Form(
      key: formKeyEntertainmentProgramme,
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
                    getTranslated(context, 'Entertainmentlicense',
                            'entertainment_programme')
                        .toUpperCase(),
                    style: whiteBoldText16,
                    maxLines: null,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Text(
              getTranslated(
                  context, 'Entertainmentlicense', 'entertainment_place'),
              style: formLabelStyle,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  for (var i = 0; i < 2; i += 1)
                    Row(
                      children: [
                        Checkbox(
                          checkColor: blackColor,
                          value: isChecked[i],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked[i] = value!;
                              if (isChecked[i]) {
                                if (selected_place.toString().isNotEmpty) {
                                  selected_place = selected_place + ' , ';
                                } else {
                                  selected_place = place_option[i];
                                }
                              }
                            });
                          },
                        ),
                        Text('${place_option[i]}'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                ],
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(
                  context, 'Entertainmentlicense', 'entertainment_type'),
            ),
            EmptyWidget(),
            DropDownWidget(
                lable: 'Select Entertainment Programme', // label for dropdown
                list: entertainment_list, // list for fill dropdown
                selValue: entertainment_select, // selected value
                selectValue: (value) {
                  setState(() {
                    entertainment_select = value;
                  });
                }),
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
                    getTranslated(context, 'Entertainmentlicense',
                            'upload_document_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'Entertainmentlicense', 'doc_ty'),
            ),
            DropDownWidget(
                lable: 'Select Document Type',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  print(value);
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'Entertainmentlicense', 'doc_dis'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText:
                    getTranslated(context, 'Entertainmentlicense', 'doc_dis'),
                isDense: true,
              ),
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
           /* !isFileExits
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
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(docList[index].document_type)),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewImage(
                                                filepath: docList[index]
                                                    .document_path,
                                                filename: docList[index]
                                                    .document_name)));
                                  },
                                  child: Icon(Icons.remove_red_eye),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deleteDocument(
                                        docList[index].id.toString());
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
      EntmtLicenseApplicantDetailsModel applicantDetailsModel =
          new EntmtLicenseApplicantDetailsModel(
              DFT_DTL_ENTMT_LIC_APPL_DTL_ID: '',
              appl_org_name: nameT.text,
              familty_id: familyIdT.text,
              parent_spouse_name: parentNameT.text,
              add_line_1: address1T.text,
              add_line_2: address2T.text,
              mobile_no: mobileNoT.text,
              pin_code: pincodeT.text,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new EntmtLicenseModel(
          applicantDetailsModel: applicantDetailsModel,
          propertyDetailsModel:
              licenseModel == null ? null : licenseModel!.propertyDetailsModel,
          programDetailsModel:
              licenseModel == null ? null : licenseModel!.programDetailsModel,
          entertainmentDocumentModel: licenseModel == null
              ? null
              : licenseModel!.entertainmentDocumentModel);

      MstAddApplicationModel mstAddApplicationModel =
          new MstAddApplicationModel(
              id: applicationId.isEmpty ? null : int.parse(applicationId),
              cATEGORYID: widget.categoryId,
              sERVICEID: widget.serviceId,
              aPPLICATIONNAME: widget.title,
              service_name: widget.servieName,
              gENERATEDAPPLICATIONID: '',
              aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
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

  void savePropertyDetails() async {
    if (formKeyPropertyDetails.currentState!.validate()) {
      EntmtLicensePropertyDetailsModel licensePropertyDetailsModel =
          new EntmtLicensePropertyDetailsModel(
              dft_dtl_entmt_lic_prop_dtl_id: '',
              district_id: selectedDistId,
              taluka_id: selectedTalukaId,
              gram_id: selectedPanchayatId,
              village_id: selectedVillageId,
              property_id: selectedProperty,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: "Y");

      licenseModel = new EntmtLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licensePropertyDetailsModel,
          programDetailsModel: licenseModel!.programDetailsModel,
          entertainmentDocumentModel: licenseModel!.entertainmentDocumentModel);

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

  void saveEntertainmentProgramme() async {
    if (formKeyEntertainmentProgramme.currentState!.validate()) {
      if (selected_place == '') {
        showMessageToast('Please Select Place');
      } else {
        for (var i = 0; i < 2; i += 1) {
          if (isChecked[i]) {
            entmtPlace = entmtPlace.isEmpty
                ? entmtPlace = (i + 1).toString()
                : entmtPlace = entmtPlace + '#' + (i + 1).toString();
          }
        }
        EntmtLicenseProgramDetailsModel programdetailsModel =
            new EntmtLicenseProgramDetailsModel(
                dft_dtl_entmt_lic_prog_id: '',
                ent_prog_conducted: entmtPlace,
                ent_prog_type_id: entertainment_select,
                crt_date: '',
                crt_user: '',
                crt_ip: '',
                lst_upd_ip: '',
                lst_upd_date: '',
                lst_upd_user: '',
                status: 'Y');

        licenseModel = new EntmtLicenseModel(
            applicantDetailsModel: licenseModel!.applicantDetailsModel,
            propertyDetailsModel: licenseModel!.propertyDetailsModel,
            programDetailsModel: programdetailsModel,
            entertainmentDocumentModel:
                licenseModel!.entertainmentDocumentModel);

        var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(licenseModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());

        if (i > 0) {
          showMessageToast('Entertainment Programme details draft');
          if (_currentStep < getSteps().length) {
            setState(() => _currentStep += 1);
          }
        } else {
          showMessageToast('Something went wrong !');
        }
      }
    }
  }

  void saveDocumentDetails(String flag) async {
  //  if (filePath.isNotEmpty) {
      EntmtLicenseDocumentDetailsModel documentDetailsModel =
          new EntmtLicenseDocumentDetailsModel(
              dft_dtl_entmt_lic_upload_id: '',
              trn_doc_id: '',
              doc_id: filePath,
              doc_type: docTypeSelect,
              doc_desc: documentDecT.text,
              crt_date: '',
              crt_user: '',
              crt_ip: '',
              lst_upd_ip: '',
              lst_upd_date: '',
              lst_upd_user: '',
              status: 'Y');

      licenseModel = new EntmtLicenseModel(
          applicantDetailsModel: licenseModel!.applicantDetailsModel,
          propertyDetailsModel: licenseModel!.propertyDetailsModel,
          programDetailsModel: licenseModel!.programDetailsModel,
          entertainmentDocumentModel: documentDetailsModel);

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
    //}
  }

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);
     print(jsonEncode(jsonData));

      licenseModel = new EntmtLicenseModel(
          applicantDetailsModel:
              jsonData.containsKey('1') && jsonData["1"] != null
                  ? EntmtLicenseApplicantDetailsModel.fromJson(jsonData["1"])
                  : null,
          propertyDetailsModel:
              jsonData.containsKey('2') && jsonData["2"] != null
                  ? EntmtLicensePropertyDetailsModel.fromJson(jsonData["2"])
                  : null,
          programDetailsModel:
              jsonData.containsKey('3') && jsonData["3"] != null
                  ? EntmtLicenseProgramDetailsModel.fromJson(jsonData["3"])
                  : null,
          entertainmentDocumentModel:
              jsonData.containsKey('4') && jsonData["4"] != null
                  ? EntmtLicenseDocumentDetailsModel.fromJson(jsonData["4"])
                  : null);

      if (licenseModel!.applicantDetailsModel != null) {
        nameT.text = licenseModel!.applicantDetailsModel!.appl_org_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.familty_id;
        parentNameT.text =
            licenseModel!.applicantDetailsModel!.parent_spouse_name;
        address1T.text = licenseModel!.applicantDetailsModel!.add_line_1;
        address2T.text = licenseModel!.applicantDetailsModel!.add_line_2;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mobile_no;
        pincodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
      }

      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.taluka_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gram_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;
        selectedProperty = licenseModel!.propertyDetailsModel!.property_id;

        districtName =
            await DatabaseOperation.instance.getDistrictName(selectedDistId);
        talukaName =
            await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(selectedPanchayatId);
        villageName =
            await DatabaseOperation.instance.getVillageName(selectedVillageId);
      }

      if (licenseModel!.programDetailsModel != null) {
        checkbox_value = licenseModel!.programDetailsModel!.ent_prog_conducted;
        if (checkbox_value.contains('#')) {
          for (var i = 0; i < 2; i += 1) {
            isChecked[i] = true;
            if (selected_place.toString().isNotEmpty) {
              selected_place = selected_place + ' , ' + place_option[i];
            } else {
              selected_place = place_option[i];
            }
          }
        } else {
          checkbox_value == '1' ? isChecked[0] = true : isChecked[1] = true;
          checkbox_value == '1'
              ? selected_place = place_option[0]
              : selected_place = place_option[1];
        }
        entertainment_select =
            licenseModel!.programDetailsModel!.ent_prog_type_id;
      }

      /*if (licenseModel!.entertainmentDocumentModel != null) {
        filePath = licenseModel!.entertainmentDocumentModel!.doc_id;
        var fname = licenseModel!.entertainmentDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
        docTypeSelect = licenseModel!.entertainmentDocumentModel!.doc_type;
        documentDecT.text = licenseModel!.entertainmentDocumentModel!.doc_desc;
      }*/

      if (_currentStep < getSteps().length - 1) {
        if (int.parse(model.current_tab) == getSteps().length - 1) {
          _currentStep = getSteps().length - 1;

        } else {
          _currentStep = int.parse(model.current_tab) + 1;
        }
      }

      if (_currentStep == 3) {
        isFileExits = false;
        getAllDocument(applicationId);
      }

      /*if(int.parse(model.current_tab)==getSteps().length - 1){

      }*/
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
    List<DropDownModal> user;
    var construction;
    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId);
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId);
    docTypeSelect_Label = await DatabaseOperation.instance
        .getDropdownName("getMstDocData", docTypeSelect);
    entertainment_select_label = await DatabaseOperation.instance
        .getDropdownName("getMstEntertProgTypeData", entertainment_select);

    selected_place = '';
    for (var i = 0; i < 2; i += 1) {
      if (isChecked[i]) {
        if (selected_place.toString().isNotEmpty) {
          selected_place = selected_place + ' , ' + place_option[i];
        } else {
          selected_place = place_option[i];
        }
      }
    }

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
                              getTranslated(context, 'Entertainmentlicense',
                                  'applicant_details'),
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
                                      getTranslated(context, 'Entertainmentlicense', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      nameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'parent_nm'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      parentNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNoT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'pincode'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      pincodeT.text,
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
                              getTranslated(context, 'Entertainmentlicense',
                                  'property_village_details'),
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
                                      getTranslated(context, 'Building_License',
                                          'district'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      districtName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'taluka'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      talukaName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'panchayat'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      panchayatName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Building_License',
                                          'village'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      villageName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'Entertainmentlicense', 'property'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      selectedProperty,
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
                              getTranslated(context, 'Entertainmentlicense',
                                  'entertainment_programme'),
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
                                          context, 'Entertainmentlicense', 'entertainment_place'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      selected_place,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'Entertainmentlicense', 'entertainment_type'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      entertainment_select_label,
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
                              upload_document_details,
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
                                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(child: Text(docList[index].document_type)),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => ViewImage(
                                                                            filepath: docList[index]
                                                                                .document_path,
                                                                            filename: docList[index]
                                                                                .document_name)));
                                                              },
                                                              child: Icon(Icons.remove_red_eye),
                                                            ),
                                                            // SizedBox(
                                                            //   width: 10,
                                                            // ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     deleteDocument(
                                                            //         docList[index].id.toString());
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
                                     /* Text(
                                        doc_ty,
                                        style: graypreviewText13,
                                      ),
                                      Text(
                                        docTypeSelect_Label,
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
          //Navigator.pop(context);
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
    //  purposeList = await DatabaseOperation.instance.getDropdown("getMstPurposeData");
    entertainment_list = await DatabaseOperation.instance
        .getDropdown("getMstEntertProgTypeData", "5", "18");
    docTypeList = await DatabaseOperation.instance
        .getDropdown("getMstDocData", "5", "18");
  }

  void insertDocument() async {
    if (docTypeSelect.isEmpty) {
      showMessageToast('Please select document type');
    } else if (filePath.isEmpty || fileName.isEmpty) {
      showMessageToast('Please choose file !');
    } else if (applicationId.isEmpty || applicationId == '0') {
      showMessageToast('Application id not found !');
    } else {
      MstAppDocumentModel model = new MstAppDocumentModel(
          id: null,
          document_id: docTypeSelect,
          document_type: await DatabaseOperation.instance
              .getDropdownNameUsingCategory(widget.categoryId, widget.serviceId,
                  "getMstDocData", docTypeSelect),
          document_description: documentDecT.text,
          document_name: fileName,
          document_path: filePath,
          app_trn_id: applicationId,
          sync_status: "N");

      int i = await DatabaseOperation.instance.insertDocument(model);

      if (i > 0) {
        showMessageToast('Document inserted successfully');
        formKeyDoc.currentState!.reset();
        docTypeSelect = '';
        documentDecT.text = '';
        filePath = '';
        fileName = '';
        setState(() {});
        getAllDocument(applicationId);
      } else {
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
        if (i > 0) {
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
