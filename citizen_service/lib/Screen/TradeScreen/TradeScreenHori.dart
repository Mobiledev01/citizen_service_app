import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Screen/TradeScreen/FactoryClearance.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DropDownWidget.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/UploadDocumentWidget.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class TradeScreenHori extends StatefulWidget {
  const TradeScreenHori({Key? key}) : super(key: key);

  @override
  _TradeScreen createState() => _TradeScreen();
}

class _TradeScreen extends State<TradeScreenHori> {
  late List<bool> isChecked = [false, false, false];
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  int val = -1;
  List<DropDownModal> serviceList = [
    DropDownModal(id: '1', title: 'subservice', titleKn: ''),
  ];
  String? serviceSelect;

  bool draftApplication = true;

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final formKeyPropertyDetails = GlobalKey<FormState>();
  final formKeyLicenseDetails = GlobalKey<FormState>();

  String fileName = '';

  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trade_license),
        backgroundColor:
        globals.isTrainingMode ? testModePrimaryColor : primaryColor,

        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              onPressed: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FactoryClearance()));*/
              },
              icon: Icon(Icons.add),
            ),
          ),
          isNetCon
              ? IconButton(
            icon: Icon(
              Icons.wifi_outlined,
              color: greenColor,
              size: 20,
            ),
            onPressed: () {},
          )
              : IconButton(
            icon: Icon(
              Icons.wifi_off_outlined,
              color: redColor,
              size: 20,
            ),
            onPressed: () {},
          ),
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
                  if (_currentStep < getSteps().length - 1) {
                    print(_currentStep);

                    if (!draftApplication && _currentStep == 0) {
                      if (formKeyApplicantDetails.currentState!.validate() &&
                          _currentStep < getSteps().length) {
                        setState(() => _currentStep += 1);
                      }
                    } else if (!draftApplication && _currentStep == 1) {
                      if (formKeyPropertyDetails.currentState!.validate() &&
                          _currentStep < getSteps().length) {
                        setState(() => _currentStep += 1);
                      }
                    } else if (!draftApplication && _currentStep == 2) {
                      if (formKeyLicenseDetails.currentState!.validate() &&
                          _currentStep < getSteps().length) {
                        setState(() => _currentStep += 1);
                      }
                    } else {
                      if (_currentStep < getSteps().length) {
                        setState(() => _currentStep += 1);
                      }
                    }
                  } else {
                    showMessageToast('submit');
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
                              child: Text(submit, style: whiteNormalText14))
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    applicant_details.toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            
            EmptyWidget(),
            TextFormField(
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: applicant_name,
              ),
              validator: (name) {
                if (name.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              keyboardType: TextInputType.name,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: family_name,
              ),
              validator: (spouseName) {
                if (spouseName.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              keyboardType: TextInputType.phone,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: mobile_number,
              ),
              validator: (mobileNo) {
                if (mobileNo.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              // focusNode: focusNodeMobileNo,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: family_id,
              ),
              validator: (familyId) {
                if (familyId.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              minLines: 3,
              maxLines: null,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: address_line_1,
              ),
              validator: (address) {
                if (address.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              // focusNode: focusNodeMobileNo,
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: locality,
              ),
              validator: (locality) {
                if (locality.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              // focusNode: focusNodeMobileNo,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: pincode,
              ),
              validator: (pincode) {
                if (pincode.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            Text(
              occupancy_detail,
              style: formLabel,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  for (var i = 0; i < 3; i += 1)
                    Row(
                      children: [
                        Checkbox(
                          checkColor: blackColor,
                          value: isChecked[i],
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked[i] = value!;
                            });
                          },
                        ),
                        Text('${occupancy_text[i]}'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget propertyDetailsWidget() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    property_village_details.toUpperCase(),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    license_details.toUpperCase(),
                    style: whiteBoldText16,
                  ),
                ),
              ),
            ),
            
            EmptyWidget(),
            Text(
              type,
              style: formLabel,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (int? value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: secondcolor,
                    ),
                    Text('New')
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (int? value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: secondcolor,
                    ),
                    Text('Renewal')
                  ],
                ),
              ],
            ),
            EmptyWidget(),
            Text(
              sub_service,
              style: formLabel,
            ),
            DropDownWidget(
                lable: 'Select SubService', // label for dropdown
                list: serviceList, // list for fill dropdown
                selValue: serviceSelect, // selected value
                selectValue: (value) {
                  // function return value after dropdown selection changed
                  print(value.id + ',' + value.title);
                }),
            EmptyWidget(),
            TextFormField(
              keyboardType: TextInputType.text,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: trade_name,
              ),
              validator: (tradeName) {
                if (tradeName.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: land_area,
              ),
              validator: (landArea) {
                if (landArea.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
            TextFormField(
              // controller: loginEmailController,
              keyboardType: TextInputType.number,
              style: blackNormalText16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blackColor)),
                hintText: building_area,
              ),
              validator: (buildingArea) {
                if (buildingArea.toString().isNotEmpty)
                  return null;
                else
                  return 'add validation';
              },
            ),
            EmptyWidget(),
          ],
        ),
      ),
    );
  }

  Widget uploadDocumentWidget() {
    return Container(
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
                  upload_document_details.toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          
          EmptyWidget(),
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
                  });
                } else {
                  PlatformFile file = value;
                  print(file.path! + ',' + file.name);
                  setState(() {
                    fileName = file.name;
                  });
                }
              }),
          !isFileExits
              ? Align(
            alignment: Alignment.center,
            child: Text(
              'File not found !',
              style: TextStyle(color: redColor, fontSize: 15),
            ),
          )
              : SizedBox(),
          EmptyWidget(),
          isPreviewApplication
              ? Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    openInstruction();
                  },
                  style: previewButtonBlueStyle,
                  child:
                  Text(preview_application, style: whiteNormalText14)))
              : SizedBox(),
          EmptyWidget(),
        ],
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

  void openInstruction() {
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
            actions: [
              Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: cancelButtonBlueStyle,
                      child: Text(ok, style: whiteNormalText14)))
            ],
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            preview_application,
                            style: blackBoldText16,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        
                        ExpansionTile(
                          backgroundColor: lightGrayColor,
                          title: Text(
                            applicant_details,
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: whiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          backgroundColor: lightGrayColor,
                          title: Text(
                            property_village_details,
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: whiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        ExpansionTile(
                          backgroundColor: lightGrayColor,
                          title: Text(
                            building_details,
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: whiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        ExpansionTile(
                          backgroundColor: lightGrayColor,
                          title: Text(
                            upload_document_details,
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: whiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
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
}
