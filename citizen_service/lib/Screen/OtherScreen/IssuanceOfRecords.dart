import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/DropDownWidget.dart';
import 'package:citizen_service/Utility/EmptyWidget.dart';
import 'package:citizen_service/Utility/GetVillageWidget.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/Validation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class IssuanceOfRecords extends StatefulWidget {
  @override
  _IssuanceOfRecordsState createState() => _IssuanceOfRecordsState();
}

class _IssuanceOfRecordsState extends State<IssuanceOfRecords> {
  final formKeyApplicantDetails = GlobalKey<FormState>();

  final applicationName = TextEditingController();
  final mobileNumber = TextEditingController();
  final emailId = TextEditingController();

  final applicationNameFocusNode = FocusNode();
  final mobileNumberFocusNode = FocusNode();
  final emailIdFocusNode = FocusNode();

  List<DropDownModal> infoList = [];
  String? infoSelect;

  String? selectedDistId;
  String? selectedTalukaId;
  String? selectedPanchayatId;
  String? selectedVillageId;

  bool isFileExits = true;
  bool isNetCon = false;
  bool isPreviewApplication = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    infoList.add(
        new DropDownModal(title: 'infoList 1', titleKn: 'infoList 1', id: '1'));
    infoList.add(
        new DropDownModal(title: 'infoList 2', titleKn: 'infoList 2', id: '2'));
    infoList.add(
        new DropDownModal(title: 'infoList 3', titleKn: 'infoList 3', id: '3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
          title: Text(issuance_of_records),
          backgroundColor:
              globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        ),
        body: Container(
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            padding: EdgeInsets.fromLTRB(6, 10, 6, 6),
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
                              applicant_details.toUpperCase(),
                              style: whiteBoldText16,
                            ),
                          ),
                        ),
                      ),
                      EmptyWidget(),
                      Text(
                        applicant_name,
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        controller: applicationName,
                        focusNode: applicationNameFocusNode,
                        keyboardType: TextInputType.text,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          isDense: true,
                          hintText: applicant_name,
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
                          emailIdFocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      Text(
                        email_id,
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        controller: emailId,
                        focusNode: emailIdFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        style: blackNormalText16,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          isDense: true,
                          hintText: email_id,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) {
                          if (email.toString().isEmpty)
                            return 'Enter email ID';
                          else if (!validEmail(email!))
                            return 'Enter valid email ID';
                          else
                            return null;
                        },
                        onFieldSubmitted: (String value) {
                          mobileNumberFocusNode.requestFocus();
                        },
                      ),
                      EmptyWidget(),
                      Text(
                        mobile_number,
                        style: formLabelStyle,
                      ),
                      TextFormField(
                        controller: mobileNumber,
                        focusNode: mobileNumberFocusNode,
                        keyboardType: TextInputType.phone,
                        style: blackNormalText16,
                        maxLength: 10,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor)),
                          isDense: true,
                          hintText: mobile_number,
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
                      Text(
                        information,
                        style: grayNormalText14,
                      ),
                      EmptyWidget(),
                      DropDownWidget(
                          lable: 'Select info',
                          list: infoList,
                          selValue: infoSelect,
                          selectValue: (value) {
                            setState(() {
                              infoSelect = value;
                            });
                          }),
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: submitButtonBlueStyle,
                          onPressed: () {
                            submitApplication();
                          },
                          child: Text(
                            draft_save.toUpperCase(),
                            style: whiteNormalText16,
                          ),
                        ),
                      ),
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
                                  child: Text(preview_application,
                                      style: whiteNormalText14)))
                          : SizedBox(),
                      EmptyWidget(),
                    ],
                  ),
                ),
              ),
            )));
  }

  void submitApplication() {
    var jsonData = {
      'applicantName': applicationName.text,
      'mobileNo': mobileNumber.text,
      'email': emailId.text,
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
