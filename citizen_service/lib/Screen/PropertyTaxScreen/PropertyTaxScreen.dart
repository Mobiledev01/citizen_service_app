import 'package:citizen_service/Model/DropDownModel.dart';
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
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class PropertyTaxScreen extends StatefulWidget {

  final String categoryId, serviceId, title, applicationId, servieName;

  const PropertyTaxScreen(
      {Key? key, required this.title, required this.categoryId, required this.serviceId,
        required this.applicationId,required this.servieName})
      : super(key: key);

  @override
  _PropertyTaxScreenState createState() => _PropertyTaxScreenState();
}

class _PropertyTaxScreenState extends State<PropertyTaxScreen> {
  List<DropDownModal> problemList = [];
  String problemSelect = '';
  bool draftApplication = true;
  final applicationName = TextEditingController();
  final mobileNumber = TextEditingController();
  final landmarkLocation = TextEditingController();
  final emailIdT = TextEditingController();

  final applicationNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final landmarkLocationFocusNode = FocusNode();
  final emailIdFocusNode = FocusNode();

  final formKeyApplicantDetails = GlobalKey<FormState>();
  final GlobalKey expansionTileKey1 = GlobalKey();

  String selectedDistId = '';
  String selectedTalukaId = '';
  String selectedPanchayatId = '';
  String selectedVillageId = '';
  String districtName = '';
  String talukaName = '';
  String panchayatName = '';
  String villageName = '';
  String problemListLabel = '';

  String applicationId = '';
  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;
  var search_Radio;


  @override
  void initState() {
    super.initState();
    getDropdownData();
    getConnectivity();
    if (widget.applicationId.isNotEmpty && widget.applicationId != '0') {
      setState(() {
        applicationId = widget.applicationId;
      });
      //fetchApplicationData(applicationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(property_tax),
          actions: [
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
            isPreviewApplication
                ? IconButton(
              icon: Icon(
                Icons.preview,
                color: whiteColor,
                size: 25,
              ),
              onPressed: () {
                //openInstruction();
              },
            )
                : SizedBox(),
          ],
          backgroundColor:
          globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        ),
        body: (selectedVillageId == '' && widget.applicationId.isNotEmpty)
            ? Loading()
            : Container(
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            padding: EdgeInsets.fromLTRB(8, 10, 8, 6),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKeyApplicantDetails,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card(
                      //   color: globals.isTrainingMode
                      //       ? testModePrimaryColor
                      //       : primaryColor,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topRight: Radius.circular(30),
                      //           bottomLeft: Radius.circular(30))),
                      //   elevation: 0,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(7.0),
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         getTranslated(context, 'DrinkingWater',
                      //             'applicant_details')
                      //             .toUpperCase(),
                      //         style: whiteBoldText16,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      EmptyWidget(),
                      Text(
                        getTranslated(
                            context, 'DrinkingWater', 'applicant_name'),
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        focusNode: applicationNameFocusNode,
                        controller: applicationName,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          isDense: true,
                          hintText: getTranslated(
                              context, 'DrinkingWater', 'applicant_name'),
                        ),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
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
                      Text(
                        getTranslated(
                            context, 'DrinkingWater', 'mobile_number'),
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        controller: mobileNumber,
                        focusNode: mobileNumberFocusNode,
                        keyboardType: TextInputType.phone,
                        style: blackNormalText16,
                        maxLength: 10,
                        decoration: InputDecoration(                          isDense: true,

                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText: getTranslated(
                              context, 'DrinkingWater', 'mobile_number'),
                        ),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (mobileNo) {
                          if (mobileNo.toString().isEmpty)
                            return 'Enter mobile number';
                          else if (!mobile(mobileNo!))
                            return 'Please Enter Valid Mobile Number[Start With 6-9]';
                          else
                            return null;
                        },
                      ),

                      Text(
                        getTranslated(context, 'RoadCuttingPermission', 'email_id'),
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        controller: emailIdT,
                        focusNode: emailIdFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          hintText:
                          getTranslated(context, 'RoadCuttingPermission', 'email_id'),
                          isDense: true,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (emailId) {
                          if (emailId.toString().isEmpty)
                            return 'Enter email Id';
                          else if (!validEmail(emailId!))
                            return 'Please Enter Valid Email Id';
                          else
                            return null;
                        },
                      ),
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
                          ),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: blackNormalText16,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              hintText:search,
                              isDense: true,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                          EmptyWidget(),
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
                          style: TextStyle(
                              color: redColor, fontSize: 15),
                        ),
                      )
                          : SizedBox(),
                      // EmptyWidget(),
                      // isPreviewApplication
                      //     ? Align(
                      //         alignment: Alignment.center,
                      //         child: ElevatedButton(
                      //             onPressed: () {
                      //               if (formKeyApplicantDetails
                      //                   .currentState!
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
            )));
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

  void saveApplication(String flag) async {
    if (globals.isTrainingMode) {
      showMessageToast('Water Maintenance details draft Training Mode');
    } else if (formKeyApplicantDetails.currentState!.validate()) {
      // DrinkingWaterApplication model = new DrinkingWaterApplication(
      //   "",
      //   applicationName.text,
      //   mobileNumber.text,
      //   selectedDistId,
      //   selectedTalukaId,
      //   selectedPanchayatId,
      //   selectedVillageId,
      //   landmarkLocation.text,
      //   problemSelect,
      //   problem.text,
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "Y",
      // );
      // drinkingWaterModel = new DrinkingWaterModel(model);
      //
      // MstAddApplicationModel mstAddApplicationModel =
      // new MstAddApplicationModel(
      //     id: applicationId.isEmpty ? null : int.parse(applicationId),
      //     cATEGORYID: widget.categoryId,
      //     sERVICEID: widget.serviceId,
      //     aPPLICATIONNAME: widget.title,
      //     service_name: widget.servieName,
      //     gENERATEDAPPLICATIONID: '',
      //     aPPLICATIONAPPLYDATE: getCurrentDateUsingFormatter('dd/MM/yyyy'),
      //     aPPLICATIONDATA: jsonEncode(drinkingWaterModel),
      //     aPPLICATIONSYNCSTATUS: 'N',
      //     aPPLICATIONSYNCDATE: '',
      //     crt_user: '',
      //     crt_date: getCurrentDateUsingFormatter('dd/MM/yyyy'),
      //     lst_upd_user: '',
      //     lst_upd_date: applicationId.isNotEmpty
      //         ? getCurrentDateUsingFormatter('dd/MM/yyyy')
      //         : '',
      //     current_tab: "1",
      //     from_web: '',
      //     draft_id: '',
      //     aPPVERSION: await getAppVersion());
      //
      // var i;
      //
      // if (applicationId.isNotEmpty && applicationId != '0') {
      //   i = await DatabaseOperation.instance.updateMstAddApplicationModel(
      //       applicationId,
      //       jsonEncode(drinkingWaterModel),
      //       getCurrentDateUsingFormatter('DD/MM/YYYY'),
      //       "1");
      // } else {
      //   i = await DatabaseOperation.instance
      //       .insertMstAddApplicationModel(mstAddApplicationModel);
      // }
      //
      // if (i > 0) {
      //   setState(() {
      //     applicationId = applicationId.isEmpty ? i.toString() : applicationId;
      //   });
      //
      //   if (flag == 'save') {
      //     var j = await DatabaseOperation.instance
      //         .updateFinalApplicationStatus(applicationId);
      //     await DatabaseOperation.instance
      //         .updateSyncMessageStatus(applicationId, '');
      //     if (j > 0) {
      //       showMessageToast('Application Submit Successfully');
      //     }
      //   } else {
      //     showMessageToast('Water Maintenance details draft');
      //   }
      //   Navigator.pop(context);
      // } else {
      //   showMessageToast('Something went wrong !');
      // }
    }
  }

  // void fetchApplicationData(String applicationId) async {
  //   MstAddApplicationModel? model =
  //   await DatabaseOperation.instance.getApplicationUsingID(applicationId);
  //   if (model != null && model.aPPLICATIONDATA.isNotEmpty) {
  //     var jsonData = jsonDecode(model.aPPLICATIONDATA);
  //     drinkingWaterModel = new DrinkingWaterModel(
  //         jsonData.containsKey('1') && jsonData["1"] != null
  //             ? DrinkingWaterApplication.fromJson(jsonData["1"])
  //             : null);
  //     if (drinkingWaterModel!.drinkingWaterApplication != null) {
  //       applicationName.text =
  //           drinkingWaterModel!.drinkingWaterApplication!.applicant_name;
  //       mobileNumber.text =
  //           drinkingWaterModel!.drinkingWaterApplication!.mob_no;
  //       selectedDistId =
  //           drinkingWaterModel!.drinkingWaterApplication!.district_id;
  //       selectedTalukaId =
  //           drinkingWaterModel!.drinkingWaterApplication!.taluka_id;
  //       selectedPanchayatId =
  //           drinkingWaterModel!.drinkingWaterApplication!.panchayat_id;
  //       selectedVillageId =
  //           drinkingWaterModel!.drinkingWaterApplication!.village_id;
  //       landmarkLocation.text =
  //           drinkingWaterModel!.drinkingWaterApplication!.landmark_location;
  //       problemSelect = drinkingWaterModel!
  //           .drinkingWaterApplication!.problem_description_id;
  //       problem.text =
  //           drinkingWaterModel!.drinkingWaterApplication!.problem_type;
  //       isPreviewApplication = true;
  //
  //       districtName = await DatabaseOperation.instance.getDistrictName(
  //           drinkingWaterModel!.drinkingWaterApplication!.district_id);
  //       talukaName = await DatabaseOperation.instance.getTalukaName(
  //           drinkingWaterModel!.drinkingWaterApplication!.taluka_id);
  //       panchayatName = await DatabaseOperation.instance.getPanchayatName(
  //           drinkingWaterModel!.drinkingWaterApplication!.panchayat_id);
  //       villageName = await DatabaseOperation.instance.getVillageName(
  //           drinkingWaterModel!.drinkingWaterApplication!.village_id);
  //
  //       setState(() {});
  //     }
  //   }
  // }
  //
  // Future<void> openInstruction() async {
  //   districtName =
  //   await DatabaseOperation.instance.getDistrictName(selectedDistId);
  //   talukaName =
  //   await DatabaseOperation.instance.getTalukaName(selectedTalukaId);
  //   panchayatName =
  //   await DatabaseOperation.instance.getPanchayatName(selectedPanchayatId);
  //   villageName =
  //   await DatabaseOperation.instance.getVillageName(selectedVillageId);
  //   problemListLabel = await DatabaseOperation.instance
  //       .getDropdownName("getMstProblemDetails", problemSelect);
  //
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async => true,
  //         child: AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0)),
  //           insetPadding: EdgeInsets.all(20),
  //           backgroundColor: whiteColor,
  //           elevation: 5,
  //           actions: [
  //             Align(
  //                 alignment: Alignment.topRight,
  //                 child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     style: cancelButtonBlueStyle,
  //                     child: Text(ok, style: whiteNormalText14))),
  //           ],
  //           content: StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //               return Container(
  //                 //height: MediaQuery.of(context).size.height / 2,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Align(
  //                         alignment: Alignment.topCenter,
  //                         child: Text(
  //                           preview_application,
  //                           style: blackBoldText16,
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                       Card(
  //                         color: primaryColor,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius:
  //                             BorderRadius.all(Radius.circular(10))),
  //                         child: ExpansionTile(
  //                           // collapsedBackgroundColor: primaryColor,
  //                           // backgroundColor: primaryColor,
  //                           key: expansionTileKey1,
  //                           collapsedIconColor: whiteColor,
  //                           title: Text(
  //                             getTranslated(context, 'DrinkingWater',
  //                                 'applicant_details'),
  //                             style: whiteBoldText16,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                           children: [
  //                             Container(
  //                               width: double.infinity,
  //                               decoration: previewBoxDecoration,
  //                               padding: previewContainerPadding,
  //                               //padding: const EdgeInsets.all(5.0),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'DrinkingWater', 'applicant_name'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     applicationName.text,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'DrinkingWater', 'mobile_number'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     mobileNumber.text,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'Building_License', 'district'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     districtName,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(context, 'Building_License', 'taluka'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     talukaName,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'Building_License', 'panchayat'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     panchayatName,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(context, 'Building_License', 'village'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     villageName,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'DrinkingWater', 'enter_problem'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     problemListLabel,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                   Divider(thickness: 1),
  //                                   Text(
  //                                     getTranslated(
  //                                         context, 'DrinkingWater', 'problem_des'),
  //                                     style: graypreviewText13,
  //                                   ),
  //                                   Text(
  //                                     problem.text,
  //                                     style: grayBoldText16,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                           onExpansionChanged: (bool value) {
  //                             if (value) {
  //                               _scrollToSelectedContent(
  //                                   expansionTileKey: expansionTileKey1);
  //                             }
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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

        if(formKeyApplicantDetails.currentState!.validate()){
          saveApplication('draft');
        }
        Navigator.pop(context);
      },
    );

    Widget okButton2 = TextButton(
      child: Text('Save Application'),
      onPressed: () async {
        if(formKeyApplicantDetails.currentState!.validate()){
          saveApplication('draft');
        }
        Navigator.pop(context);
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
