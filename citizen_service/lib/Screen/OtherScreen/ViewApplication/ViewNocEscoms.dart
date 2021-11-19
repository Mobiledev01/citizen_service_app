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
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class ViewNocEscoms extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId;

  const ViewNocEscoms(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId})
      : super(key: key);

  @override
  _ViewNocEscomsState createState() => _ViewNocEscomsState();
}

class _ViewNocEscomsState extends State<ViewNocEscoms> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  String fileName = '';
  String applicationId = '';
  String filePath = '';
  bool draftApplication = false;
  bool isFileExits = true;

  var search_Radio;

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

  List<DropDownModal> docTypeList = [];
  List<MstAppDocumentModel> docList = [];
  String docTypeSelect = '';
  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  @override
  void initState() {
    super.initState();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });

      fetchApplicationData(applicationId);
    }

    docTypeList.add(new DropDownModal(
        title: 'docTypeList 1', titleKn: 'docTypeList 1', id: '1'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 2', titleKn: 'docTypeList 2', id: '2'));
    docTypeList.add(new DropDownModal(
        title: 'docTypeList 3', titleKn: 'docTypeList 3', id: '3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
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
          isActive: _currentStep >= 0,
       //   state: _currentStep == 0 ? StepState.editing : StepState.complete,
          content: applicantDetailsWidget()),
      Step(
        title: new Text('', style: formTitle),
        content: propertyDetailsWidget(),
        isActive: _currentStep >= 1,
        // state: _currentStep == 1
        //     ? StepState.editing
        //     : _currentStep < 1
        //         ? StepState.disabled
        //         : StepState.complete,
      ),
      Step(
        title: new Text('', style: formTitle),
        content: uploadDocumentWidget(),
        isActive: _currentStep >= 2,
        // state: _currentStep == 2
        //     ? StepState.editing
        //     : _currentStep < 2
        //         ? StepState.disabled
        //         : StepState.complete,
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
                    bottomLeft: Radius.circular(30))),            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(
                      context, 'IssuanceOfEscoms', 'applicant_details').toUpperCase(),
                  style: whiteBoldText16,
                ),
              ),
            ),
          ),
          EmptyWidget(),
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
    );
  }

  Widget propertyDetailsWidget() {
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
                    bottomLeft: Radius.circular(30))),            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, 'IssuanceOfEscoms',
                      'property_village_details').toUpperCase(),
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
            selectedDistId ?? '',
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'taluka'),
            style: graypreviewText13,
          ),
          Text(
            selectedTalukaId ?? '',
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'panchayat'),
            style: graypreviewText13,
          ),
          Text(
            selectedPanchayatId ?? '',
            style: grayBoldText16,
          ),
          Divider(thickness: 1),
          Text(
            getTranslated(context, 'Building_License',
                'village'),
            style: graypreviewText13,
          ),
          Text(
            selectedVillageId ?? '',
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
            search_Radio == 1 ? search_property_id : search_name,
            style: grayBoldText16,
          )
        ],
      ),
    );
  }

  Widget uploadDocumentWidget() {
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
                  getTranslated(context, 'IssuanceOfEscoms',
                      'upload_document_details').toUpperCase(),
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
        /*  Text(
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
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: () {
                  if (filePath.isNotEmpty) {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewImage(
                                filepath: filePath, filename: fileName)));
                  } else {
                    showMessageToast('No Image to display');
                  }
                },
                icon: Icon(
                  fileName.contains('pdf') ? Icons.picture_as_pdf : Icons.image,
                  size: 35,
                  color: whiteColor,
                ),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Text(fileName,
                        style: whiteBoldText14, overflow: TextOverflow.ellipsis),
                  ),
                ),
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

      NocEscomsModel Model = new NocEscomsModel(
          jsonData.containsKey('1') && jsonData["1"] != null
              ? NocEscomsApplicant.fromJson(jsonData["1"])
              : null,
          jsonData.containsKey('2') && jsonData["2"] != null
              ? NocEcomsProperty.fromJson(jsonData["2"])
              : null,
          jsonData.containsKey('3') && jsonData["3"] != null
              ? NocEcomsDoc.fromJson(jsonData["3"])
              : null);

      if (Model.nocEscomsApplicant != null) {
        applicationNameT.text = Model.nocEscomsApplicant!.appl_name;
        familyIdT.text = Model.nocEscomsApplicant!.family_id;
        parentNameT.text = Model.nocEscomsApplicant!.parent_spouse_name;
        address1T.text = Model.nocEscomsApplicant!.address_line_1;
        address2T.text = Model.nocEscomsApplicant!.address_line_2;
        mobileNumberT.text = Model.nocEscomsApplicant!.mob_no;
        pincodeT.text = Model.nocEscomsApplicant!.pin_code;
      }

      if (Model.nocEcomsProperty != null) {
        selectedDistId = await DatabaseOperation.instance.getDistrictName(Model.nocEcomsProperty!.district_id);
        selectedTalukaId = await DatabaseOperation.instance.getTalukaName(Model.nocEcomsProperty!.tp_id);
        selectedPanchayatId = await DatabaseOperation.instance.getPanchayatName(Model.nocEcomsProperty!.gp_id);
        selectedVillageId = await DatabaseOperation.instance.getVillageName(Model.nocEcomsProperty!.village_id);
        propertyIdT.text = Model.nocEcomsProperty!.property;
        search_Radio =
            Model.nocEcomsProperty!.search_by == search_property_id ? 1 : 2;
      }

     /* if (Model.nocEcomsDoc != null) {
        filePath = Model.nocEcomsDoc!.doc_id;
        var fname = Model.nocEcomsDoc!.doc_id.split("/");
        fileName = fname[fname.length - 1];
        docTypeSelect = await DatabaseOperation.instance.getDropdownName("getMstDocData", Model.nocEcomsDoc!.doc_type_id);

        documentDecT.text = Model.nocEcomsDoc!.doc_desc;
        bool fileE = await new File(filePath).exists();
        if (!fileE) {
          isFileExits = false;
        }
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
