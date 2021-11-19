import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsApplicant.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsDoc.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsModel.dart';
import 'package:citizen_service/Model/NocEscoms/NocEscomsProperty.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class IssuanceOfNocEscoms extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const IssuanceOfNocEscoms(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _IssuanceOfNocEscomsState createState() => _IssuanceOfNocEscomsState();
}

class _IssuanceOfNocEscomsState extends State<IssuanceOfNocEscoms> {
  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyDocDetails = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  String fileName = '';
  String applicationId = '';
  String filePath = '';
  bool draftApplication = false;
  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;
  List<MstAppDocumentModel> docList = [];

  var search_Radio;

  NocEscomsModel? Model;

  final applicationNameT = TextEditingController();
  final familyIdT = TextEditingController();
  final parentNameT = TextEditingController();
  final mobileNumberT = TextEditingController();
  final address1T = TextEditingController();
  final address2T = TextEditingController();
  final pincodeT = TextEditingController();
  final familyMemberT = TextEditingController();
  final propertyIdT = TextEditingController();
  final eastT = TextEditingController();
  final southT = TextEditingController();
  final westT = TextEditingController();
  final northT = TextEditingController();
  final documentDecT = TextEditingController();

  final applicationNameFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final parentNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();
  final familyMemberFocusNode = FocusNode();
  final propertyIdFocusNode = FocusNode();
  final eastFocusNode = FocusNode();
  final southFocusNode = FocusNode();
  final westFocusNode = FocusNode();
  final northFocusNode = FocusNode();
  final documentDecFocusNode = FocusNode();

  List<DropDownModal> docTypeList = [];
  String docTypeSelect = '';
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';
  String docTypeSelect_label = '';

  @override
  void initState() {
    super.initState();
    getConnectivity();
    getDropdownData();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });

      fetchApplicationData(applicationId);
    }

    /*docTypeList.add(new DropDownModal(
        title: 'docTypeList 1', titleKn: 'docTypeList 1', id: '1'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 2', titleKn: 'docTypeList 2', id: '2'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 3', titleKn: 'docTypeList 3', id: '3'));*/
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
            actions: [
              // isNetCon
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
            title: Text(issuance_noc_escoms),
            backgroundColor:
                globals.isTrainingMode ? testModePrimaryColor : primaryColor,
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
                                  child:
                                      Text(previous, style: whiteNormalText14)),
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
                                  child:
                                      Text(save_next, style: whiteNormalText14)),
                        ],
                      );
                    },
                  ),
                )),
              ],
            ),
          )),
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
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 2,
        state: _currentStep == 2
            ? StepState.editing
            : _currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }

  void saveApplicantDetails() async {
    var jsonData = {
      'applicantName': applicationNameT.text,
      'familyName': parentNameT.text,
      'mobileNo': mobileNumberT.text,
      'familyId': familyIdT.text,
      'addressLine1': address1T.text,
      'addressLine2': address2T.text,
      'pincode': pincodeT.text,
    };

    if (formKeyApplicantDetails.currentState!.validate()) {
      NocEscomsApplicant nocEscomsApplicant = new NocEscomsApplicant(
          '',
          applicationNameT.text,
          parentNameT.text,
          familyIdT.text,
          address1T.text,
          address2T.text,
          mobileNumberT.text,
          pincodeT.text,
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          'Y');

      Model = new NocEscomsModel(nocEscomsApplicant,
          Model?.nocEcomsProperty ?? null, Model?.nocEcomsDoc ?? null);

      MstAddApplicationModel mstAddApplicationModel =
          new MstAddApplicationModel(
              id: applicationId.isEmpty ? null : int.parse(applicationId),
              cATEGORYID: widget.categoryId,
              sERVICEID: widget.serviceId,
              aPPLICATIONNAME: widget.title,
              service_name: widget.servieName,
              gENERATEDAPPLICATIONID: '',
              aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
              aPPLICATIONDATA: jsonEncode(Model),
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
            jsonEncode(Model),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());
      } else {
        i = await DatabaseOperation.instance
            .insertMstAddApplicationModel(mstAddApplicationModel);
      }

      if (i > 0) {
        setState(() {
          applicationId = applicationId.isEmpty ? i.toString() : applicationId;
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
    var jsonData = {
      'selectedDistId': selectedDistId,
      'selectedTalukaId': selectedTalukaId,
      'selectedPanchayatId': selectedPanchayatId,
      'selectedVillageId': selectedVillageId,
      'propertySelect': propertyIdT,
    };

    if (formKeyPropertyDetails.currentState!.validate()) {
      if (search_Radio != null) {
        NocEcomsProperty nocEcomsProperty = new NocEcomsProperty(
            '',
            selectedDistId!,
            selectedTalukaId!,
            selectedPanchayatId!,
            selectedVillageId!,
            "njksdnk",
            // == 1 ? search_property_id : search_name,
            propertyIdT.text,
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            '',
            "Y");

        Model = new NocEscomsModel(Model?.nocEscomsApplicant ?? null,
            nocEcomsProperty, Model?.nocEcomsDoc ?? null);

        var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(Model),
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
      } else {
        showMessageToast('Select Search Type');
      }
    }
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
                            context, 'IssuanceOfEscoms', 'applicant_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'IssuanceOfEscoms', 'applicant_name'),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              focusNode: applicationNameFocusNode,
              controller: applicationNameT,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'IssuanceOfEscoms', 'applicant_name'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (name) {
                if (name.toString().isEmpty)
                  return 'Enter applicant name';
                else if (!simpleText(name!))
                  return 'Please Enter Only Text';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                parentNameFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'IssuanceOfEscoms', 'parent_spouse_name'),
            ),
            TextFormField(
              controller: parentNameT,
              focusNode: parentNameFocusNode,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'IssuanceOfEscoms', 'parent_spouse_name'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (spouseName) {
                if (spouseName.toString().isEmpty)
                  return 'Enter spouse name';
                else if (!textWithOutSpace(spouseName!))
                  return 'Please Enter Only Text With No Space';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                mobileNumberFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'IssuanceOfEscoms', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNumberT,
              focusNode: mobileNumberFocusNode,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              maxLength: 10,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:
                    getTranslated(context, 'IssuanceOfEscoms', 'mobile_number'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (mobileNo) {
                if (mobileNo.toString().isEmpty)
                  return 'Enter mobile number';
                else if (!mobile(mobileNo!))
                  return 'Please Enter Valid Mobile Number[Start With 6-9]';
                else
                  return null;
              },
              onFieldSubmitted: (String value) {
                familyIdFocusNode.requestFocus();
              },
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'IssuanceOfEscoms', 'family_id'),
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
                isDense: true,
                hintText:
                    getTranslated(context, 'IssuanceOfEscoms', 'family_id'),
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
              getTranslated(context, 'IssuanceOfEscoms', 'address_line_1'),

            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              focusNode: address1FocusNode,
              minLines: 3,
              controller: address1T,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'IssuanceOfEscoms', 'address_line_1'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address) {
                if (address.toString().isEmpty)
                  return 'Enter address line 1';
                else if (!textareaWithoutSpecialCharacter(address!))
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
              getTranslated(context, 'IssuanceOfEscoms', 'address_line_2'),
            ),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              focusNode: address2FocusNode,
              maxLines: null,
              controller: address2T,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(
                    context, 'IssuanceOfEscoms', 'address_line_2'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (address) {
                if (address.toString().isEmpty)
                  return 'Enter address line 2';
                else if (!textareaWithoutSpecialCharacter(address!))
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
              getTranslated(context, 'IssuanceOfEscoms', 'pincode'),
            ),
            TextFormField(
              controller: pincodeT,
              maxLength: 6,
              focusNode: pincodeFocusNode,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(context, 'IssuanceOfEscoms', 'pincode'),
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
                    getTranslated(context, 'IssuanceOfEscoms',
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
              getTranslated(context, 'IssuanceOfEscoms', 'property'),
            ),
            TextFormField(
              controller: propertyIdT,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blackColor)),
                  isDense: true,
                  hintText:
                      getTranslated(context, 'IssuanceOfEscoms', 'property'),
                  hintMaxLines: 2),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (propertyId) {
                if (propertyId.toString().isEmpty)
                  return 'Enter property ';
                else if (!simpleText(propertyId!))
                  return 'Please Enter Only Text';
                else
                  return null;
              },
            ),
            Column(
              children: [
                Row(children: [
                  Radio(
                    value: 1,
                    groupValue: search_Radio,
                    onChanged: (index3) {
                      setState(() {
                        search_Radio = index3;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  Text(search_property_id, style: blackNormalText14),
                ]),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: search_Radio,
                      onChanged: (index4) {
                        setState(() {
                          search_Radio = index4;
                        });
                        print(search_Radio);
                      },
                      activeColor: Colors.green,
                    ),
                    Text(search_name, style: blackNormalText14),
                  ],
                )
              ],
            ),
            ElevatedButton(
              style: downloadButtonBlueStyle,
              onPressed: () {},
              child: Text(
                search.toUpperCase(),
                style: whiteNormalText16,
              ),
            ),
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
      key: formKeyDocDetails,
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
                    getTranslated(context, 'IssuanceOfEscoms',
                            'upload_document_details')
                        .toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'IssuanceOfEscoms', 'doc_ty'),
            ),
            DropDownWidget(
                lable: 'Select type',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            Text(
              getTranslated(context, 'IssuanceOfEscoms', 'doc_dis'),
              style: formLabelStyle,
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(context, 'IssuanceOfEscoms', 'doc_dis'),
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (doc_dis) {
              //   if (doc_dis.toString().isNotEmpty)
              //     return null;
              //   else
              //     return 'Enter document description  ';
              // },
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
            EmptyWidget(),
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

  void saveDocumentDetails(String flag) async {
    //if (filePath.isNotEmpty) {
      NocEcomsDoc nocEcomsDoc = new NocEcomsDoc(
          '',
          '',
          filePath,
          docTypeSelect,
          documentDecT.text,
          fileName,
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          'Y');

      Model = new NocEscomsModel(Model?.nocEscomsApplicant ?? null,
          Model?.nocEcomsProperty ?? null, nocEcomsDoc);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(Model),
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

      Model = new NocEscomsModel(
          jsonData.containsKey('1') && jsonData["1"] != null
              ? NocEscomsApplicant.fromJson(jsonData["1"])
              : null,
          jsonData.containsKey('2') && jsonData["2"] != null
              ? NocEcomsProperty.fromJson(jsonData["2"])
              : null,
          jsonData.containsKey('3') && jsonData["3"] != null
              ? NocEcomsDoc.fromJson(jsonData["3"])
              : null);

      if (Model!.nocEscomsApplicant != null) {
        applicationNameT.text = Model!.nocEscomsApplicant!.appl_name;
        familyIdT.text = Model!.nocEscomsApplicant!.family_id;
        parentNameT.text = Model!.nocEscomsApplicant!.parent_spouse_name;
        address1T.text = Model!.nocEscomsApplicant!.address_line_1;
        address2T.text = Model!.nocEscomsApplicant!.address_line_2;
        mobileNumberT.text = Model!.nocEscomsApplicant!.mob_no;
        pincodeT.text = Model!.nocEscomsApplicant!.pin_code;
      }

      if (Model!.nocEcomsProperty != null) {
        selectedDistId = Model!.nocEcomsProperty!.district_id;
        selectedTalukaId = Model!.nocEcomsProperty!.tp_id;
        selectedPanchayatId = Model!.nocEcomsProperty!.gp_id;
        selectedVillageId = Model!.nocEcomsProperty!.village_id;
        propertyIdT.text = Model!.nocEcomsProperty!.property;
        search_Radio =
            Model!.nocEcomsProperty!.search_by == search_property_id ? 1 : 2;

        districtName = await DatabaseOperation.instance
            .getDistrictName(Model!.nocEcomsProperty!.district_id);
        talukaName = await DatabaseOperation.instance
            .getTalukaName(Model!.nocEcomsProperty!.tp_id);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(Model!.nocEcomsProperty!.gp_id);
        villageName = await DatabaseOperation.instance
            .getVillageName(Model!.nocEcomsProperty!.village_id);
      }

     /* if (Model!.nocEcomsDoc != null) {
        filePath = Model!.nocEcomsDoc!.doc_id;
        var fname = Model!.nocEcomsDoc!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        docTypeSelect = Model!.nocEcomsDoc!.doc_type_id;
        documentDecT.text = Model!.nocEcomsDoc!.doc_desc;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
      }*/

      if (_currentStep < getSteps().length - 1) {
        if (int.parse(model.current_tab) == getSteps().length - 1) {
          _currentStep = getSteps().length - 1;

        } else {
          _currentStep = int.parse(model.current_tab) + 1;
        }
      }
      /*if(int.parse(model.current_tab)==getSteps().length - 1){

      }*/
      if (_currentStep == 2) {
        isFileExits = false;
        getAllDocument(applicationId);
      }
      isPreviewApplication = true;
      setState(() {});
    }
  }

  Future<void> openInstruction() async {
    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId ?? '');
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId ?? '');
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId ?? '');
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId ?? '');
    docTypeSelect_label = await DatabaseOperation.instance
        .getDropdownName("getMstDocData", docTypeSelect);

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
                            key: expansionTileKey1,
                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(
                                  context, 'IssuanceOfEscoms', 'applicant_details'),
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
                                      getTranslated(context, 'IssuanceOfEscoms', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicationNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'parent_spouse_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      parentNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNumberT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'IssuanceOfEscoms', 'pincode'),
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
                              getTranslated(context, 'IssuanceOfEscoms',
                                  'property_village_details'),
                              style: whiteBoldText16,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: previewBoxDecoration,
                                padding: previewContainerPadding,
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
                                      getTranslated(context, 'IssuanceOfEscoms', 'property'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      propertyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      search,
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      search_Radio == 1
                                          ? search_property_id
                                          : search_Radio == 2 ? search_name : '',
                                      style: grayBoldText16,
                                    )
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
                            key: expansionTileKey3,
                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(context, 'IssuanceOfEscoms',
                                  'upload_document_details'),
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

                                  /*  Text(
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
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),*/
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
    //  purposeList = await DatabaseOperation.instance.getDropdown("getMstPurposeData");

    docTypeList = await DatabaseOperation.instance
        .getDropdown("getMstDocData", "5", "16");
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
        formKeyDocDetails.currentState!.reset();
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
