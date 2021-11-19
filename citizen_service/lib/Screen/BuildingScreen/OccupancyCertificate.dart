import 'dart:convert';
import 'dart:io';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateApplicantDetailModel.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateDocumentDetail.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateLicenseDetail.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificateModel.dart';
import 'package:citizen_service/Model/OccupancyCertificateModel/OccupancyCertificatePropertyDetail.dart';
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
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;
import 'package:image_picker/image_picker.dart';

class OccupancyCertificate extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const OccupancyCertificate(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _OccupancyCertificateState createState() => _OccupancyCertificateState();
}

class _OccupancyCertificateState extends State<OccupancyCertificate> {
  bool isNetCon = false;
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  bool draftApplication = false;
  bool isPreviewApplication = false;
  bool isFileExits = true;

  OccupancyCertificateModel? Model;
  bool _autoValidate = false;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyLicenseDetails = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();

  final GlobalKey expansionTileKey1 = GlobalKey();
  final GlobalKey expansionTileKey2 = GlobalKey();
  final GlobalKey expansionTileKey3 = GlobalKey();
  final GlobalKey expansionTileKey4 = GlobalKey();

  final applicationNameT = TextEditingController();
  final familyIdT = TextEditingController();
  final parentNameT = TextEditingController();
  final mobileNumberT = TextEditingController();
  final address1T = TextEditingController();
  final address2T = TextEditingController();
  final pincodeT = TextEditingController();
  final buildingLicenseT = TextEditingController();
  final documentDecT = TextEditingController();

  final applicationNameFocusNode = FocusNode();
  final familyIdFocusNode = FocusNode();
  final parentNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final pincodeFocusNode = FocusNode();

  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;
  String? propertySelect;
  String? docTypeSelect;
  String fileName = '';
  String filePath = '';
  String applicationId = '';
  String docTypeSelectLabel = '';

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  List<DropDownModal> properList = [];
  List<MstAppDocumentModel> docList = [];
  List<DropDownModal> docTypeList = [];

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

    properList.add(new DropDownModal(
        title: 'properList 1', titleKn: 'properList 1', id: '1'));
    properList.add(new DropDownModal(
        title: 'properList 2', titleKn: 'properList 2', id: '2'));
    properList.add(new DropDownModal(
        title: 'properList 3', titleKn: 'properList 3', id: '3'));
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
            title: Text(occupancy_certificate),
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
                                  child:
                                      Text(previous, style: whiteNormalText14)),
                          SizedBox(
                            width: 10,
                          ),
                          getSteps().length - 1 == _currentStep
                              ? ElevatedButton(
                                  onPressed: onStepContinue,
                                  style: submitButtonBlueStyle,
                                  child: Text(draft_or_save,
                                      style: whiteNormalText14))
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
        content: licenseDeatils(),
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
                    getTranslated(context, 'OccupancyCertificate', 'applicant_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'OccupancyCertificate', 'applicant_details'),
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
                hintText:getTranslated(context, 'OccupancyCertificate', 'applicant_details'),
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
              getTranslated(context, 'OccupancyCertificate', 'parent_spouse_name'),
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
                hintText: getTranslated(context, 'OccupancyCertificate', 'parent_spouse_name'),
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
              getTranslated(context, 'OccupancyCertificate', 'mobile_number'),
            ),
            TextFormField(
              controller: mobileNumberT,
              focusNode: mobileNumberFocusNode,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:  getTranslated(context, 'OccupancyCertificate', 'mobile_number'),
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
              getTranslated(context, 'OccupancyCertificate', 'family_id'),
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
                hintText:  getTranslated(context, 'OccupancyCertificate', 'family_id'),
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
              getTranslated(context, 'OccupancyCertificate', 'address_line_1'),
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
                hintText:  getTranslated(context, 'OccupancyCertificate', 'address_line_1'),
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
              getTranslated(context, 'OccupancyCertificate', 'address_line_2'),
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
                hintText:     getTranslated(context, 'OccupancyCertificate', 'address_line_2'),
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
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'OccupancyCertificate', 'pincode'),
            ),
            TextFormField(
              controller: pincodeT,
              // focusNode: focusNodeMobileNo,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              maxLength: 6,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:  getTranslated(context, 'OccupancyCertificate', 'pincode'),
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
                    getTranslated(context, 'OccupancyCertificate', 'property_village_details').toUpperCase(),
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
              getTranslated(context, 'OccupancyCertificate', 'property'),
            ),
            DropDownWidget(
                lable: 'Select Property Id', // label for dropdown
                list: properList, // list for fill dropdown
                selValue: propertySelect, // selected value
                selectValue: (value) {
                  // function return value after dropdown selection changed
                  propertySelect = value;
                }),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  Widget licenseDeatils() {
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
                    getTranslated(context, 'OccupancyCertificate', 'license_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'OccupancyCertificate', 'building_license_no'),
            ),
            TextFormField(
              controller: buildingLicenseT,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText: getTranslated(context, 'OccupancyCertificate', 'building_license_no'),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.toString().isEmpty)
                  return 'Enter Building License Number';
                else if (!onlyDigit(value!))
                  return 'Please Enter Only Number';
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
                      getTranslated(context, 'OccupancyCertificate', 'upload_document_details').toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            EmptyWidget(),
            Text(
              getTranslated(context, 'OccupancyCertificate', 'doc_ty'),
              textAlign: TextAlign.start,
              style: formLabelStyle,
            ),
            DropDownWidget(
                lable: 'Select type ',
                list: docTypeList,
                selValue: docTypeSelect,
                selectValue: (value) {
                  setState(() {
                    docTypeSelect = value;
                  });
                }),
            EmptyWidget(),
            labelField(
              getTranslated(context, 'OccupancyCertificate', 'doc_dis'),
            ),
            TextFormField(
              controller: documentDecT,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {
              //   if (value.toString().isEmpty)
              //     return 'Enter Document Description';
              //   else if (!onlyTextWithSpace(value!))
              //     return 'Please Enter Only Text';
              //   else
              //     return null;
              // },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                isDense: true,
                hintText:   getTranslated(context, 'OccupancyCertificate', 'doc_dis'),
              ),
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
      OccupancyCertificateApplicantDetail occupancyCertificateApplicantDetail =
          new OccupancyCertificateApplicantDetail(
              "",
              applicationNameT.text,
              familyIdT.text,
              parentNameT.text,
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
              "N");

      Model = new OccupancyCertificateModel(
          occupancyCertificateApplicantDetail,
          Model?.occupancyCertificatePropertyDetail ?? null,
          Model?.occupancyCertificateLicenseDetail ?? null,
          Model?.occupancyCertificateDocumentDetail ?? null);

      MstAddApplicationModel model = new MstAddApplicationModel(
          crt_user: '',
          aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
          cATEGORYID: widget.categoryId,
          aPPLICATIONSYNCDATE: '',
          sERVICEID: widget.serviceId,
          gENERATEDAPPLICATIONID: '',
          current_tab: _currentStep.toString(),
          aPPLICATIONDATA: jsonEncode(Model),
          crt_date: getCurrentDateUsingFormatter('dd/MM/yyyy'),
          lst_upd_user: '',
          lst_upd_date: applicationId.isNotEmpty
              ? getCurrentDateUsingFormatter('dd/MM/yyyy')
              : '',
          aPPVERSION: await getAppVersion(),
          id: applicationId.isEmpty ? null : int.parse(applicationId),
          aPPLICATIONSYNCSTATUS: 'N',
          from_web: '',
          draft_id: '',
          aPPLICATIONNAME: widget.title,
          service_name: widget.servieName);

      var i;
      if (applicationId.isNotEmpty && applicationId != '0') {
        i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(Model),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            _currentStep.toString());
      } else {
        i = await DatabaseOperation.instance
            .insertMstAddApplicationModel(model);
      }

      if (i > 0) {
        setState(() {
          applicationId = applicationId.isEmpty ? i.toString() : applicationId;
        });
        showMessageToast('Applicant details draft');
      } else {
        showMessageToast('Something went wrong !');
      }
      if (_currentStep < getSteps().length) {
        setState(() => _currentStep += 1);
      }
    }
  }

  void savePropertyDetails() async {
    if(formKeyPropertyDetails.currentState!.validate()){ OccupancyCertificatePropertyDetail occupancyCertificatePropertyDetail =
    new OccupancyCertificatePropertyDetail(
        '',
        selectedDistId!,
        selectedTalukaId!,
        selectedPanchayatId!,
        selectedVillageId!,
        propertySelect!,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        'N');

    Model = new OccupancyCertificateModel(
        Model?.occupancyCertificateApplicantDetail ?? null,
        occupancyCertificatePropertyDetail,
        Model?.occupancyCertificateLicenseDetail ?? null,
        Model?.occupancyCertificateDocumentDetail ?? null);

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

    }
  }

  void saveLicenseDetails() async {
if(formKeyLicenseDetails.currentState!.validate()){
  OccupancyCertificateLicenseDetail occupancyCertificateLicenseDetail =
  new OccupancyCertificateLicenseDetail(
      '', buildingLicenseT.text, '', '', '', '', '', '', '', '', '', 'Y');

  Model = new OccupancyCertificateModel(
      Model?.occupancyCertificateApplicantDetail ?? null,
      Model?.occupancyCertificatePropertyDetail ?? null,
      occupancyCertificateLicenseDetail,
      Model?.occupancyCertificateDocumentDetail ?? null);

  var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
      applicationId,
      jsonEncode(Model),
      getCurrentDateUsingFormatter('DD/MM/YYYY'),
      _currentStep.toString());

  if (i > 0) {
    showMessageToast('Building details draft');
    if (_currentStep < getSteps().length) {
      setState(() => _currentStep += 1);
    }
  } else {
    showMessageToast('Something went wrong !');
  }
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

  void saveDocumentDetails(String flag) async {
   // if (filePath.isNotEmpty) {
      OccupancyCertificateDocumentDetail occupancyCertificateDocumentDetail =
          new OccupancyCertificateDocumentDetail(
              '',
              '',
              filePath,
              fileName,
              '',
              '',
              '',
              '',
              docTypeSelect!,
              documentDecT.text,
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              '',
              'N');

      Model = new OccupancyCertificateModel(
          Model?.occupancyCertificateApplicantDetail ?? null,
          Model?.occupancyCertificatePropertyDetail ?? null,
          Model?.occupancyCertificateLicenseDetail ?? null,
          occupancyCertificateDocumentDetail);

      var i = await DatabaseOperation.instance.updateMstAddApplicationModel(
          applicationId,
          jsonEncode(Model),
          getCurrentDateUsingFormatter('DD/MM/YYYY'),
          _currentStep.toString());

      if (i > 0) {
        if (flag == 'save') {
          var j = await DatabaseOperation.instance.updateFinalApplicationStatus(applicationId);
          await DatabaseOperation.instance.updateSyncMessageStatus(applicationId, '');
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

  Future<void> openInstruction() async {
    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId ?? '');
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId ?? '');
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId ?? '');
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId ?? '');
    docTypeSelectLabel = await DatabaseOperation.instance
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
                              getTranslated(context, 'OccupancyCertificate', 'applicant_details'),
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
                                      getTranslated(context, 'OccupancyCertificate', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicationNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'parent_spouse_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      parentNameT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNumberT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'family_id'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      familyIdT.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'address_line_1'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address1T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'address_line_2'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      address2T.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'pincode'),
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
                              getTranslated(context, 'OccupancyCertificate', 'property_village_details'),
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
                                    Text( getTranslated(context, 'Building_License',
                                        'taluka'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      talukaName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text( getTranslated(context, 'Building_License',
                                        'panchayat'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      panchayatName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text( getTranslated(context, 'Building_License',
                                        'village'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      villageName,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(context, 'OccupancyCertificate', 'property'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      propertySelect ?? '',
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
                            key: expansionTileKey3,
                            collapsedIconColor: whiteColor,
                            title: Text(
                              getTranslated(context, 'OccupancyCertificate', 'license_details'),
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
                                      getTranslated(context, 'OccupancyCertificate', 'building_license_no'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      buildingLicenseT.text,
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
                              getTranslated(context, 'OccupancyCertificate', 'upload_document_details'),
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
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
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
                                      docTypeSelectLabel,
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

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      Model = new OccupancyCertificateModel(
          jsonData.containsKey('1') && jsonData["1"] != null
              ? OccupancyCertificateApplicantDetail.fromJson(jsonData["1"])
              : null,
          jsonData.containsKey('2') && jsonData["2"] != null
              ? OccupancyCertificatePropertyDetail.fromJson(jsonData["2"])
              : null,
          jsonData.containsKey('3') && jsonData["3"] != null
              ? OccupancyCertificateLicenseDetail.fromJson(jsonData["3"])
              : null,
          jsonData.containsKey('4') && jsonData["4"] != null
              ? OccupancyCertificateDocumentDetail.fromJson(jsonData["4"])
              : null);


      if (Model!.occupancyCertificateApplicantDetail != null) {
        applicationNameT.text =
            Model!.occupancyCertificateApplicantDetail!.appl_name;
        familyIdT.text = Model!.occupancyCertificateApplicantDetail!.family_id;
        parentNameT.text =
            Model!.occupancyCertificateApplicantDetail!.parent_spouse_name;
        address1T.text = Model!.occupancyCertificateApplicantDetail!.add_line_1;
        address2T.text = Model!.occupancyCertificateApplicantDetail!.add_line_2;
        mobileNumberT.text = Model!.occupancyCertificateApplicantDetail!.mob_no;
        pincodeT.text = Model!.occupancyCertificateApplicantDetail!.pin_code;
      }

      if (Model!.occupancyCertificatePropertyDetail != null) {
        selectedDistId = Model!.occupancyCertificatePropertyDetail!.district_id;
        selectedTalukaId = Model!.occupancyCertificatePropertyDetail!.tp_id;
        selectedPanchayatId = Model!.occupancyCertificatePropertyDetail!.gp_id;
        selectedVillageId =
            Model!.occupancyCertificatePropertyDetail!.village_id;
        propertySelect = Model!.occupancyCertificatePropertyDetail!.property_id;

        districtName = await DatabaseOperation.instance.getDistrictName(
            Model!.occupancyCertificatePropertyDetail!.district_id);
        talukaName = await DatabaseOperation.instance
            .getTalukaName(Model!.occupancyCertificatePropertyDetail!.tp_id);
        panchayatName = await DatabaseOperation.instance
            .getPanchayatName(Model!.occupancyCertificatePropertyDetail!.gp_id);
        villageName = await DatabaseOperation.instance.getVillageName(
            Model!.occupancyCertificatePropertyDetail!.village_id);
      }

      if (Model!.occupancyCertificateLicenseDetail != null) {
        buildingLicenseT.text = Model!.occupancyCertificateLicenseDetail!.bldg_lic_num;
      }

      if (Model!.occupancyCertificateDocumentDetail != null) {
        filePath = Model!.occupancyCertificateDocumentDetail!.doc_id;
        var fname =
        Model!.occupancyCertificateDocumentDetail!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        docTypeSelect = Model!.occupancyCertificateDocumentDetail!.doc_type;
        documentDecT.text = Model!.occupancyCertificateDocumentDetail!.doc_desc;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
      }

      if (_currentStep < getSteps().length - 1) {
        if (int.parse(model.current_tab) == getSteps().length - 1) {
          _currentStep = getSteps().length - 1;

        } else {
          _currentStep = int.parse(model.current_tab) + 1;
        }
      }
      /*if(int.parse(model.current_tab)==getSteps().length - 1){

      }*/

      if (_currentStep == 3) {
        isFileExits = false;
        getAllDocument(applicationId);
      }
      isPreviewApplication = true;
      setState(() {});
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
        await DatabaseOperation.instance.getDropdown("getMstDocData", "2", "7");
  }

  void insertDocument() async {
    if (docTypeSelect!.isEmpty) {
      showMessageToast('Please select document type');
    } else if (filePath.isEmpty || fileName.isEmpty) {
      showMessageToast('Please choose file !');
    } else if (applicationId.isEmpty || applicationId == '0') {
      showMessageToast('Application id not found !');
    } else {
      MstAppDocumentModel model = new MstAppDocumentModel(
          id: null,
          document_id: docTypeSelect!,
          document_type: await DatabaseOperation.instance
              .getDropdownNameUsingCategory(widget.categoryId, widget.serviceId,
                  "getMstDocData", docTypeSelect!),
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
