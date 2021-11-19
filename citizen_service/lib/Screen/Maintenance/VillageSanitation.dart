import 'dart:convert';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAddApplicationModel.dart';
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationApplication.dart';
import 'package:citizen_service/Model/VillageSanitationModel/VillageSanitationModel.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DropDownWidget.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/Loading.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

import 'package:flutter/material.dart';

class VillageSanitation extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;

  const VillageSanitation(
      {Key? key,
      required this.title,
      required this.categoryId,
      required this.serviceId,
      required this.applicationId,
      required this.servieName})
      : super(key: key);

  @override
  _VillageSanitationState createState() => _VillageSanitationState();
}

class _VillageSanitationState extends State<VillageSanitation> {
  final applicationName = TextEditingController();
  final mobileNumber = TextEditingController();
  final landmarkLocation = TextEditingController();
  final applicationNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final landmarkLocationFocusNode = FocusNode();

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final GlobalKey expansionTileKey1 = GlobalKey();

  List<DropDownModal> problemList = [];
  String problemSelect = '';

  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;
  String applicationId = '';
  String problemSelectLabel = '';
  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;

  VillageSanitationModel? villageSanitationModel;

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
          title: Text(village_sanitation),
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        ),
        body: (selectedVillageId == null && widget.applicationId.isNotEmpty)
            ? Loading()
            : Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                decoration: BoxDecoration(),
                padding: EdgeInsets.fromLTRB(8, 5, 6, 8),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKeyApplicantDetails,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: globals.isTrainingMode
                                ? testModePrimaryColor
                                : primaryColor,
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
                                  getTranslated(context, 'VillageSanitation',
                                          'applicant_details')
                                      .toUpperCase(),
                                  style: whiteBoldText16,
                                ),
                              ),
                            ),
                          ),
                          EmptyWidget(),
                          labelField(
                            getTranslated(
                                context, 'VillageSanitation', 'applicant_name'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: blackNormalText16,
                            controller: applicationName,
                            focusNode: applicationNameFocusNode,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              isDense: true,
                              hintText: getTranslated(
                                  context, 'VillageSanitation', 'applicant_name'),
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
                              mobileNumberFocusNode.requestFocus();
                            },
                          ),
                          EmptyWidget(),
                          labelField(
                            getTranslated(
                                context, 'VillageSanitation', 'mobile_number'),
                          ),
                          TextFormField(
                            controller: mobileNumber,
                            keyboardType: TextInputType.phone,
                            focusNode: mobileNumberFocusNode,
                            style: blackNormalText16,
                            maxLength: 10,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              isDense: true,
                              hintText: getTranslated(
                                  context, 'VillageSanitation', 'mobile_number'),
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
                          ),
                          EmptyWidget(),
                          EmptyWidget(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              getTranslated(context, 'VillageSanitation',
                                  'add_of_location'),
                              ),
                          ),
                          EmptyWidget(),
                          EmptyWidget(),
                          GetVillageWidget(
                              selectedDistId: selectedDistId,
                              selectedTalukaId: selectedTalukaId,
                              selectedPanchayatId: selectedPanchayatId,
                              selectedVillageId: selectedVillageId,
                              selectValue:
                                  (district, taluka, panchayat, village) {
                                setState(() {
                                  selectedDistId = district;
                                  selectedTalukaId = taluka;
                                  selectedPanchayatId = panchayat;
                                  selectedVillageId = village;
                                });
                              }),
                          EmptyWidget(),
                          labelField(
                            getTranslated(
                                context, 'VillageSanitation', 'land_mark'),
                          ),
                          TextFormField(
                            controller: landmarkLocation,
                            keyboardType: TextInputType.text,
                            style: blackNormalText16,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              isDense: true,
                              hintText: getTranslated(
                                  context, 'VillageSanitation', 'land_mark'),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.toString().isEmpty)
                                return 'Enter Landmark of Location name';
                              else if (!onlyTextWithSpace(value!))
                                return 'Please Enter Only Text With  Space';
                              else
                                return null;
                            },
                          ),
                          EmptyWidget(),
                          labelField(
                            getTranslated(
                                context, 'VillageSanitation', 'problem_des'),
                          ),
                          DropDownWidget(
                              lable: 'Select problem',
                              list: problemList,
                              selValue: problemSelect,
                              selectValue: (value) {
                                setState(() {
                                  problemSelect = value;
                                });
                              }),
                          EmptyWidget(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: submitButtonBlueStyle,
                              onPressed: () {
                                finalSaveApplication();
                              },
                              child: Text(
                                draft_or_save,
                                style: whiteNormalText16,
                              ),
                            ),
                          ),
                          !isFileExits
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'File not found !',
                                    style:
                                        TextStyle(color: redColor, fontSize: 15),
                                  ),
                                )
                              : SizedBox(),
                          EmptyWidget(),
                          // isPreviewApplication
                          //     ? Align(
                          //         alignment: Alignment.center,
                          //         child: ElevatedButton(
                          //             onPressed: () {
                          //               if (formKeyApplicantDetails.currentState!
                          //                   .validate()) {
                          //                 openInstruction();
                          //               }
                          //             },
                          //             style: previewButtonBlueStyle,
                          //             child: Text(preview_application,
                          //                 style: whiteNormalText14)))
                          //     : SizedBox(),
                          EmptyWidget(),
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  void submitApplication() {
    var jsonData = {
      'applicantName': applicationName.text,
      'mobileNo': mobileNumber.text,
      'landmarkLocation': landmarkLocation.text,
      'problem': problemSelect,
      'selectedDistId': selectedDistId,
      'selectedTalukaId': selectedTalukaId,
      'selectedPanchayatId': selectedPanchayatId,
      'selectedVillageId': selectedVillageId
    };

    if (formKeyApplicantDetails.currentState!.validate()) {
      print(jsonData);
      showMessageToast('Applicant details uploaded');
    }
  }

  void submit(String flag) async {
    if (globals.isTrainingMode) {
      showMessageToast(
          ' VillageSanitation Maintenance details draft Training Mode');
    } else if (formKeyApplicantDetails.currentState!.validate()) {
      VillageSanitationApplication model = new VillageSanitationApplication(
        '',
        applicationName.text,
        mobileNumber.text,
        selectedDistId!,
        selectedTalukaId!,
        selectedPanchayatId!,
        selectedVillageId!,
        landmarkLocation.text,
        problemSelect,
        "",
        "",
        "",
        "",
        "",
        "",
        "Y",
      );
      villageSanitationModel = new VillageSanitationModel(model);

      MstAddApplicationModel mstAddApplicationModel =
          new MstAddApplicationModel(
              id: applicationId.isEmpty ? null : int.parse(applicationId),
              cATEGORYID: widget.categoryId,
              sERVICEID: widget.serviceId,
              aPPLICATIONNAME: widget.title,
              service_name: widget.servieName,
              gENERATEDAPPLICATIONID: '',
              aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
              aPPLICATIONDATA: jsonEncode(villageSanitationModel),
              aPPLICATIONSYNCSTATUS: 'N',
              aPPLICATIONSYNCDATE: '',
              crt_user: '',
              crt_date: getCurrentDateUsingFormatter('dd/MM/yyyy'),
              lst_upd_user: '',
              lst_upd_date: applicationId.isNotEmpty
                  ? getCurrentDateUsingFormatter('dd/MM/yyyy')
                  : '',
              current_tab: "1",
              from_web: '',
              draft_id: '',
              aPPVERSION: await getAppVersion());

      var i;

      if (applicationId.isNotEmpty && applicationId != '0') {
        i = await DatabaseOperation.instance.updateMstAddApplicationModel(
            applicationId,
            jsonEncode(villageSanitationModel),
            getCurrentDateUsingFormatter('DD/MM/YYYY'),
            "1");
      } else {
        i = await DatabaseOperation.instance
            .insertMstAddApplicationModel(mstAddApplicationModel);
      }

      if (i > 0) {
        setState(() {
          applicationId = applicationId.isEmpty ? i.toString() : applicationId;
        });
        if (flag == 'save') {
          var j = await DatabaseOperation.instance
              .updateFinalApplicationStatus(applicationId);
          await DatabaseOperation.instance
              .updateSyncMessageStatus(applicationId, '');
          if (j > 0) {
            showMessageToast('Application Submit Successfully');
          }
        } else {
          showMessageToast('Water Maintenance details draft');
        }
        Navigator.pop(context);
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

  void fetchApplicationData(String applicationId) async {
    MstAddApplicationModel? model =
        await DatabaseOperation.instance.getApplicationUsingID(applicationId);
    if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
      var jsonData = jsonDecode(model.aPPLICATIONDATA);
      villageSanitationModel = new VillageSanitationModel(
          jsonData.containsKey('1') && jsonData["1"] != null
              ? VillageSanitationApplication.fromJson(jsonData["1"])
              : null);
      if (villageSanitationModel!.villageSanitationApplication != null) {
        applicationName.text = villageSanitationModel!
            .villageSanitationApplication!.applicant_name;
        mobileNumber.text =
            villageSanitationModel!.villageSanitationApplication!.mob_no;
        selectedDistId =
            villageSanitationModel!.villageSanitationApplication!.district_id;
        selectedTalukaId =
            villageSanitationModel!.villageSanitationApplication!.taluka_id;
        selectedPanchayatId =
            villageSanitationModel!.villageSanitationApplication!.panchayat_id;
        selectedVillageId =
            villageSanitationModel!.villageSanitationApplication!.village_id;
        landmarkLocation.text = villageSanitationModel!
            .villageSanitationApplication!.landmark_location;
        problemSelect = villageSanitationModel!
            .villageSanitationApplication!.problem_description_id;

        districtName = await DatabaseOperation.instance.getDistrictName(
            villageSanitationModel!.villageSanitationApplication!.district_id);
        talukaName = await DatabaseOperation.instance.getTalukaName(
            villageSanitationModel!.villageSanitationApplication!.taluka_id);
        panchayatName = await DatabaseOperation.instance.getPanchayatName(
            villageSanitationModel!.villageSanitationApplication!.panchayat_id);
        villageName = await DatabaseOperation.instance.getVillageName(
            villageSanitationModel!.villageSanitationApplication!.village_id);
        isPreviewApplication = true;
        setState(() {});
      }
    }
  }

  Future<void> openInstruction() async {
    districtName =
        await DatabaseOperation.instance.getDistrictName(selectedDistId!);
    talukaName =
        await DatabaseOperation.instance.getTalukaName(selectedTalukaId!);
    panchayatName =
        await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId!);
    villageName =
        await DatabaseOperation.instance.getVillageName(selectedVillageId!);
    problemSelectLabel = await DatabaseOperation.instance
        .getDropdownName("getMstProblemDetails", problemSelect);

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
                                getTranslated(context, 'VillageSanitation',
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
                                      getTranslated(
                                          context, 'VillageSanitation', 'applicant_name'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      applicationName.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'VillageSanitation', 'mobile_number'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      mobileNumber.text,
                                      style: grayBoldText16,
                                    ),
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
                                      getTranslated(
                                          context, 'VillageSanitation', 'land_mark'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      landmarkLocation.text,
                                      style: grayBoldText16,
                                    ),
                                    Divider(thickness: 1),
                                    Text(
                                      getTranslated(
                                          context, 'VillageSanitation', 'problem_des'),
                                      style: graypreviewText13,
                                    ),
                                    Text(
                                      problemSelectLabel,
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
        submit('draft');
        if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }
        //Navigator.pop(context);
      },
    );

    Widget okButton2 = TextButton(
      child: Text('Save Application'),
      onPressed: () async {
        submit('save');
        if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
         Navigator.pop(context);
       } else {
         Navigator.of(context)
           ..pop()
           ..pop();
       }
        //Navigator.pop(context);
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
    problemList = await DatabaseOperation.instance
        .getDropdown("getMstProblemDetails", "4", "12");
  }
}
