import 'dart:convert';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseAdvertiseDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicenseModel.dart';
import 'package:citizen_service/Model/AdvtLicenseModel/AdvtLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerApplicantDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerBuildingModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerDocumentDetailsModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerModel.dart';
import 'package:citizen_service/Model/FactoryClearanceModel/FactoryPerPropertyDetailsModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/MstAppDocumentModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionApplicantDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionDocumentDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionPropertyDetailsModel.dart';
import 'package:citizen_service/Model/NewWaterConnectionModel/NewWaterConnectionWaterConnectionModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseApplicantDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseDocumentDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicensePropertyDetailsModel.dart';
import 'package:citizen_service/Model/TradeLicenseModel/TradeLicenseTypeAppModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart' as globals;

class ViewAdvtLicense extends StatefulWidget {
  final String title, categoryId, serviceId, applicationId;

  ViewAdvtLicense(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewAdvtLicense createState() => _ViewAdvtLicense();
}

class _ViewAdvtLicense extends State<ViewAdvtLicense> {
  final FocusNode focusNodeMobileNo = FocusNode();
  StepperType stepperType = StepperType.horizontal;
  int _currentStep = 0;
  int doclist_index=0;

  bool isFileExits = true;

  final  nameT = TextEditingController();
  final  parentNameT = TextEditingController();
  final  familyIdT = TextEditingController();
  final  address1T = TextEditingController();
  final  address2T = TextEditingController();
  final  mobileNoT = TextEditingController();
  final  pincodeT = TextEditingController();
  final documentDecT = TextEditingController();

  List<DropDownModal> propertyList = [
    DropDownModal(id: '1', title: 'Property', titleKn: ''),
  ];
  List<DropDownModal> factoryTypeList = [
    DropDownModal(id: '1', title: 'Select', titleKn: ''),
    DropDownModal(id: '2', title: 'Micro Industries', titleKn: ''),
  ];
  List<DropDownModal> docTypeList = [
    DropDownModal(id: '1', title: 'Dist1', titleKn: '1'),
    DropDownModal(id: '2', title: 'Dist2', titleKn: '2'),
    DropDownModal(id: '3', title: 'Dist3', titleKn: '3'),
    DropDownModal(id: '4', title: 'Dist4', titleKn: '4'),
    DropDownModal(id: '5', title: 'Dist5', titleKn: '5')
  ];
  List<MstAppDocumentModel> docList = [];
  String selectedProperty='',selectedAdvertiseSize='',selectedAdvertiseType='';
  String selectedDistId='';
  String selectedTalukaId='';
  String selectedPanchayatId='';
  String selectedVillageId='';
  String applicationId = '';
  String fileName = '';
  String filePath = '';
  String docTypeSelect = '';


  AdvtLicenseModel? licenseModel;

  @override
  void initState() {
    super.initState();

    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      fetchApplicationData(widget.applicationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(advertise_label),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                  primary: primaryColor,
                )),
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
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
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 1) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 2) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
                      } else if (!globals.isTrainingMode && _currentStep == 3) {
                        if (_currentStep < getSteps().length) {
                          setState(() => _currentStep += 1);
                        }
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
                                child:
                                    Text(previous, style: whiteNormalText14)),
                        SizedBox(
                          width: 10,
                        ),
                        getSteps().length - 1 == _currentStep
                            ? SizedBox()
                            : ElevatedButton(
                                onPressed: onStepContinue,
                                style: submitButtonBlueStyle,
                                child:
                                    Text(next_view, style: whiteNormalText14)),
                      ],
                    );
                  },
                ),
              )),
            ],
          ),
        ));
  }

  List<Step> getSteps() {
    return [
      Step(
          title: new Text('', style: formTitle),
          state: StepState.complete,
          isActive: _currentStep >= 0,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
        state: StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: advertiseDetailsWidget(),
        isActive: _currentStep >= 2,
        state: StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 3,
        state: StepState.complete,
      ),
    ];
  }

  Widget applicantDetailsWidget() {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'AdvertisementLicense', 'applicant_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
           EmptyWidget(),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'applicant_org_name'),
            style: graypreviewText13,
          ),
          Text(
            nameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'parent_nm'),
            style: graypreviewText13,
          ),
          Text(
            parentNameT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'family_id'),
            style: graypreviewText13,
          ),
          Text(
            familyIdT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'address_line_1'),
            style: graypreviewText13,
          ),
          Text(
            address1T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'address_line_2'),
            style: graypreviewText13,
          ),
          Text(
            address2T.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'mobile_number'),
            style: graypreviewText13,
          ),
          Text(
            mobileNoT.text,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'pincode'),
            style: graypreviewText13,
          ),
          Text(
            pincodeT.text,
            style: grayBoldText16,
          ),
        ],
      ),
    );
  }

  Widget propertyDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'AdvertisementLicense', 'property_village_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
         EmptyWidget(),
          Text(
            getTranslated(context, 'Building_License',
                'district'),
            style: graypreviewText13,
          ),
          Text(
            selectedDistId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Building_License',
                'taluka'),
            style: graypreviewText13,
          ),
          Text(
            selectedTalukaId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(context, 'Building_License',
                'panchayat'),

            style: graypreviewText13,
          ),
          Text(
            selectedPanchayatId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(  getTranslated(context, 'Building_License',
              'village'),
            style: graypreviewText13,
          ),
          Text(
            selectedVillageId,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'property'),
            style: graypreviewText13,
          ),
          Text(
            selectedProperty,
            style: grayBoldText16,
          ),
        ],
      ),
    );
  }

  Widget advertiseDetailsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'AdvertisementLicense', 'advertise_Details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'advertise_type'),
            style: graypreviewText13,
          ),
          Text(
            selectedAdvertiseType,
            style: grayBoldText16,
          ),
          Divider(
              thickness: 1
          ),
          Text(
            getTranslated(
                context, 'AdvertisementLicense', 'advertise_size'),
            style: graypreviewText13,
          ),
          Text(
            selectedAdvertiseSize,
            style: grayBoldText16,
          ),
        ],
      ),
    );
  }

  Widget uploadDocumentWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'AdvertisementLicense', 'upload_document_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
        EmptyWidget(),
          Card(
            elevation: 5,
            child: Container(
              // height: docList.length>0 ? 150 :0,
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

          /*  Divider(),
          Text(
            doc_ty,
            style: graypreviewText13,
          ),
          Text(
            docTypeSelect,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Padding(
                padding:EdgeInsets.all(10),
              child:
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      if (filePath.isNotEmpty) {
                        print('filepath'+filePath);
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
                      size: 25,
                      color: whiteColor,
                    ),
                    label: Text(' View ',
                        style: whiteBoldText14,
                        overflow: TextOverflow.ellipsis),
                  ),
              ),
                  Expanded(
                    child:Text(fileName,
                      style: blackNormalText14,
                      maxLines: null,),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }


  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
    await DatabaseOperation.instance.getApplicationUsingID(applicationId);

    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);

      licenseModel = new AdvtLicenseModel(
          applicantDetailsModel:
          jsonData.containsKey('1') && jsonData["1"] != null
              ? AdvtLicenseApplicantDetailsModel.fromJson(jsonData["1"])
              : null,
          propertyDetailsModel:
          jsonData.containsKey('2') && jsonData["2"] != null
              ? AdvtLicensePropertyDetailsModel.fromJson(jsonData["2"])
              : null,
          advertiseDetailsModel:
          jsonData.containsKey('3') && jsonData["3"] != null
              ? AdvtLicenseAdvertiseDetailsModel.fromJson(jsonData["3"])
              : null,
          advertiseDocumentModel:
          jsonData.containsKey('4') && jsonData["4"] != null
              ? AdvtLicenseDocumentDetailsModel.fromJson(jsonData["4"])
              : null);

      if (licenseModel!.applicantDetailsModel != null) {
        nameT.text = licenseModel!.applicantDetailsModel!.appl_name;
        familyIdT.text = licenseModel!.applicantDetailsModel!.family_id;
        parentNameT.text =
            licenseModel!.applicantDetailsModel!.parent_spouse_name;
        address1T.text = licenseModel!.applicantDetailsModel!.add_line_1;
        address2T.text = licenseModel!.applicantDetailsModel!.add_line_2;
        mobileNoT.text = licenseModel!.applicantDetailsModel!.mob_no;
        pincodeT.text = licenseModel!.applicantDetailsModel!.pin_code;
      }

      if (licenseModel!.propertyDetailsModel != null) {
        selectedDistId = licenseModel!.propertyDetailsModel!.district_id;
        selectedTalukaId = licenseModel!.propertyDetailsModel!.tp_id;
        selectedPanchayatId = licenseModel!.propertyDetailsModel!.gp_id;
        selectedVillageId = licenseModel!.propertyDetailsModel!.village_id;
        selectedProperty = licenseModel!.propertyDetailsModel!.property_id;

        selectedDistId = await DatabaseOperation.instance.getDistrictName(selectedDistId);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(selectedVillageId);

      }

      if (licenseModel!.advertiseDetailsModel != null) {
        selectedAdvertiseType = await DatabaseOperation.instance.getDropdownName("getMstAdvtBoardTypeData",   licenseModel!.advertiseDetailsModel!.type_of_advt);
        selectedAdvertiseSize =await DatabaseOperation.instance.getDropdownName("getMstAdvtBoardSizeData",  licenseModel!.advertiseDetailsModel!.size_of_advt);
      }

      /*if (licenseModel!.advertiseDocumentModel != null) {
        filePath = licenseModel!.advertiseDocumentModel!.doc_id;
        var fname = licenseModel!.advertiseDocumentModel!.doc_id.split("/");
        fileName = fname[fname.length - 1];

        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
        docTypeSelect = await DatabaseOperation.instance.getDropdownName("getMstDocData", licenseModel!.advertiseDocumentModel!.doc_type);
        documentDecT.text = licenseModel!.advertiseDocumentModel!.doc_desc;
      }*/
      getAllDocument(applicationId);
      setState(() {});
    }
  }
  void getAllDocument(String id) async {
    docList = await DatabaseOperation.instance.getAllDocument(id);

    setState(() {});
  }
}
