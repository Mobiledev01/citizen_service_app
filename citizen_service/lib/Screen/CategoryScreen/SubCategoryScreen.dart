import 'dart:convert';
import 'dart:io';

import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/MstAppCategoryModel.dart';
import 'package:citizen_service/Screen/BuildingScreen/BuildingLicenseScreen.dart';
import 'package:citizen_service/Screen/BuildingScreen/DisWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/Form%209,11/Mutation.dart';
import 'package:citizen_service/Screen/BuildingScreen/Form9.dart';
import 'package:citizen_service/Screen/BuildingScreen/OccupancyCertificate.dart';
import 'package:citizen_service/Screen/BuildingScreen/WaterConnection.dart';
import 'package:citizen_service/Screen/Maintenance/DrinkingWater.dart';
import 'package:citizen_service/Screen/Maintenance/Streetlight.dart';
import 'package:citizen_service/Screen/Maintenance/VillageSanitation.dart';
import 'package:citizen_service/Screen/OtherScreen/Entertainmentlicense.dart';
import 'package:citizen_service/Screen/OtherScreen/IssuanceOfNocEscoms.dart';
import 'package:citizen_service/Screen/OtherScreen/IssuanceOfRecords.dart';
import 'package:citizen_service/Screen/OtherScreen/RoadCuttingPermission.dart';
import 'package:citizen_service/Screen/PropertyTaxScreen/PropertyTaxScreen.dart';
import 'package:citizen_service/Screen/TradeScreen/AdvertisementLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/BusinessLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/FactoryClearance.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Loading.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/Utility/ViewInstruction.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class SubCategoryScreen extends StatefulWidget {
  String title = '', categoryId = '';

  SubCategoryScreen({Key? key, required this.title, required this.categoryId})
      : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  MstAppCategoryModel? model;

  List subCategoryList = [];
  late String categoryId, subCategoryId, servieName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.checkSubCategoryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title+' Services'),
        backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
      ),
      body: Container(
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: subCategoryList.isEmpty
                      ? Loading()
                      : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 0),
                    physics: BouncingScrollPhysics(),
                    primary: true,
                    itemCount: subCategoryList.length,
                    itemBuilder: (context, index) {
                      return _buildListSubView(context, index);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListSubView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        navigationMenu(context, subCategoryList[index]['PRE_SERVICE_ID'], subCategoryList[index]['DATA_ID'], subCategoryList[index]['DATA_VALUE']);
      },
      child: Center(
        child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.info_outline,
                    //       size: 20,
                    //       color: grayColor,
                    //     ), onPressed: () {
                    //     categoryId= subCategoryList[index]['PRE_SERVICE_ID'];
                    //     subCategoryId=subCategoryList[index]['DATA_ID'];
                    //     servieName=subCategoryList[index]['DATA_VALUE'];
                    //     var applicantJson= {
                    //       'Name of the Service Selected': 'Maintenance of Drinking Water',
                    //       'Service provided by': 'Rural Development and Panchayat Raj Department',
                    //       'Eligiblity to get this services': 'Citizens in need of this service',
                    //       'Online Application Fee': 'Free',
                    //       'Fee/Charges to be paid to get the service (Rs.)': 'Free',
                    //       'Service is expected to be delivered within (days)': '3 Days',
                    //     };
                    //     var serviceJson={
                    //         '1':'Receiving application from DEO login',
                    //         '2':'Verification of recieved Application',
                    //         '3':'Acceptance of Application in PDO',
                    //         '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
                    //         '5':'Download the issued certificate in the Certificate Download option',
                    //     };
                    //     var documnetJson={
                    //       '1':'Tax Paid Receipt *',
                    //     };
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //         builder: (context) => ViewInstruction( title: widget.title,categoryId: categoryId,
                    //         serviceId: subCategoryId,
                    //         applicationId: '',
                    //         servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson,)));
                    //   },
                    //   ),
                    //
                    // ),
                    Icon(
                     getIcons(context, subCategoryList[index]['PRE_SERVICE_ID'], subCategoryList[index]['DATA_ID']),
                      size: 35,
                      color: grayColor,
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(subCategoryList[index]['DATA_VALUE'],
                               style: TextStyle(fontSize: 13, color: Colors.black))
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
  void navigationMenu(BuildContext context, String categoryId,
      String subCategoryId, String servieName) {
    print(categoryId);
    print(subCategoryId);
  if(categoryId == '1'){
  if(subCategoryId == '1')
  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PropertyTaxScreen(
                title: widget.title,
                categoryId: categoryId,
                serviceId: subCategoryId,
                applicationId: '',
                servieName: servieName)));
  }
  }
    else if (categoryId == '2') {
      // Building Category
      if (subCategoryId == '4') {
        var applicantJson= {
          'Name of the Service Selected': 'Application for Disconnecting Water Connection',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Online Application Fee': 'Free',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Service is expected to be delivered within (days)': '3 Days',
        };
        var serviceJson={
          '1':'Receiving application from DEO login',
          '2':'Verification of recieved Application & Documents scrutiny in GP Secretary Login',
          '3':' Acceptance of Application in PDO',
          '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
        };
        var documnetJson={
          '1':'Tax Paid Receipt *',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application for Disconnecting Water Connection',categoryId: categoryId,
                  serviceId: subCategoryId,
                  applicationId: '',
                  servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));


        //
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DisconnectingWaterConnection(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else if (subCategoryId == '3') {

        var applicantJson= {
          'Name of the Service Selected': 'Application for new water connection',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Note': 'E-signing the application is mandatory in this service (be ready with aadhar number); The DigiLocker facility is available (be ready with aadhar number);',
          'Online Application Fee': 'Rs.50 /- only',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Service is expected to be delivered within (days)': '15 Days',
        };
        var serviceJson={
          '1':'Application Acceptance & Verification of Documents',
          '2':'Location investigation',
          '3':'Connecting new water',
        };
        var documnetJson={
          '1':'Tax Paid Receipt *',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application for new water connection',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));


        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => WaterConnection(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else if (subCategoryId == '2') {

        var applicantJson= {
          'Name of the Service Selected': 'Issuance of Building Permission',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Note': 'E-signing the application is mandatory in this service (be ready with aadhar number); The DigiLocker facility is available (be ready with aadhar number);',
          'Online Application Fee': 'Rs.50 /- only',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Service is expected to be delivered within (days)': '60 Days',
        };
        var serviceJson={
          '1':'Receiving application from DEO login',
          '2':'Verification of recieved Application & Documents scrutiny in GP Secretary Login',
          '3':'Acceptance of Application in PDO',
          '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
          '5':'Download the issued certificate in the Certificate Download option',
        };
        var documnetJson={
          '1':'Applicant photo *',
          '2':'Building Estimate *',
          '3':'Building Plan *',
          '4':'The extract copy of e swathu *',
          '5':'Engineer supervision certificate *',
          '6':'EPIC/Id. Proof/Ration card *',
          '7':'Indemnity Bond *',
          '8':'NOCs from concerned authority (whichever is applicable)',
          '9':'Old Licenses and Building Plan(Mod/Addl)',
          '10':'Photo of Building *',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application Details For Building License',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BuildingLicenseScreen(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      }
      // else if (subCategoryId == '6') {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => Form9(
      //               title: widget.title,
      //               categoryId: categoryId,
      //               serviceId: subCategoryId,
      //               applicationId: '',
      //               servieName: servieName)));
      // }
      else if (subCategoryId == '7') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OccupancyCertificate(
                    title: widget.title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName)));
      } else {
        showMessageToast('Coming soon');
      }
    }
    else if (categoryId == '4') {
      // Maintenance Category

      if (subCategoryId == '12') {

        var applicantJson= {
          'Name of the Service Selected': 'Maintenance of Drinking Water',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Online Application Fee': 'Free',
          'Fee/Charges to be paid to get the service (Rs.)': 'Free',
          'Service is expected to be delivered within (days)': '3 Days',
        };
        var serviceJson={
          '1':'Receiving application from DEO login',
          '2':'Verification of recieved Application',
          '3':'Acceptance of Application in PDO',
          '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
          '5':'Download the issued certificate in the Certificate Download option',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application Details For Drinking Water',categoryId: categoryId,
                  serviceId: subCategoryId,
                  applicationId: '',
                  servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: null,)));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DrinkingWater(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      }
      else if (subCategoryId == '13') {

        var applicantJson= {
          'Name of the Service Selected': 'Maintenance of street lights',
          'Service provider': 'Department of Rural Development and Panchayat Raj',
          'Necessary qualification to avail these services': 'Essential citizens of this service',
          'Online Application Fee': 'Free',
          'Fee/Charges to be paid to get the service (Rs.)': 'Free',
          'Max Time Line to Provide the Service (Days)': '3 Days',
        };
        var serviceJson={
          '1':'Acceptance of Application for Verification',
          '2':'Examination of Application',
          '3':'Approval of the application',
          '4':'Issue the certificate on PDO login using DSC after the specified time',
          '5':'Obtain the certificate in the Certificate Download option',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Details for Maintenance Application for Street Lights',categoryId: categoryId,
                  serviceId: subCategoryId,
                  applicationId: '',
                  servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: null,)));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Streetlight(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else if (subCategoryId == '14') {

        var applicantJson= {
          'Name of the Service Selected': 'Maintanace of Village sanitation',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Online Application Fee': 'Free',
          'Fee/Charges to be paid to get the service (Rs.)': 'Free',
          'Service is expected to be delivered within (days)': '7 Days',
        };
        var serviceJson={
          '1':'Receiving application from DEO login',
          '2':'Verification of recieved Application',
          '3':'Acceptance of Application in PDO',
          '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
          '5':'Download the issued certificate in the Certificate Download option',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Details For Village sanitation',categoryId: categoryId,
                  serviceId: subCategoryId,
                  applicationId: '',
                  servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: null,)));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VillageSanitation(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else {
        showMessageToast('Coming soon');
      }
    }
    else if (categoryId == '5') {
      // OtherScreen Category

      if (subCategoryId == '18') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Entertainmentlicense(
                    title: widget.title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName)));
      }else if (subCategoryId == '25') {
        showMessageToast('Coming soon');
        // Navigator.push(context,
            // MaterialPageRoute(builder: (context) => MobileTower(title: widget.title, categoryId: categoryId, serviceId: subCategoryId, applicationId: '', servieName: servieName)));
      }
      else if (subCategoryId == '16') {

        var applicantJson= {
          'Name of the Service Selected': 'ESCOMS - Objection free letter distribution',
          'Service provider': 'Department of Rural Development and Panchayat Raj',
          'Necessary qualification to avail these services': 'Essential citizens of this service',
          'Online Application Fee': 'Rs.50 /- only',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Max Time Line to Provide the Service (Days)': '7 Days',
        };
        var serviceJson={
          '1':'Acceptance of Application for Verification',
          '2':'Inspection of records',
          '3':'Application approval',
          '4':'Issue the certificate on PDO login using DSC after the specified time',
          '5':'Obtain the certificate in the Certificate Download option',
        };
        var documnetJson={
          '1':'per building permit',
          '2':'Certificate of Katha',
          '3':'Tax Payment Receipt *',

        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'ESCOMS - Details required for Objection Letter Issue Application',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => IssuanceOfNocEscoms(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else if (subCategoryId == '15') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IssuanceOfRecords()));
      } else if (subCategoryId == '17') {


        var applicantJson= {
          'Name of the Service Selected': 'Road Cutting Permission',
          'Service provider': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Residents of the Grama Panchayath area and State and Central Public Sector undertaking for official purpose.',
          'Note': 'E-signing the application is mandatory in this service (be ready with aadhar number); The DigiLocker facility is available (be ready with aadhar number)',
          'Online Application Fee': 'Rs.10 /- only',
          'Fee/Charges to be paid to get the service (Rs.)': 'Kar GramaSwaraj & PanchayatRaj Act1993 Schedule-IV',
          'Service is expected to be delivered within (days)': '40 Days',
        };
        var serviceJson={
          '1':'Receiving application for verification',
          '2':'Secretary conducts field inspection and process',
          '3':'Inspection report reviewed and demand note raised',
          '4':'Citizen can download the demand note and make payment',
          '5':'PLACING THE SUBJECT IN NEXT GRAMA PANCHAYATH MEETING',
          '6':'Permission letter get generated after successful payment',
          '7':'Download the issued certificate in the Certificate Download option',
        };
        var documnetJson={
          '1':'License Copy obtained by the resident at the time of construction of house * *',
          '2':'Copy of the house tax paid to the Grama Panchayath * *',
          '3':'Work orders issued by the cocenrned authorities*(If Applicant type is Organisation) *',

        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application Details For Road Cutting Permission',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => RoadCuttingPermission(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else {
        showMessageToast('Coming soon');
      }
    }
    /* else if (categoryId == '7') {
      // Property Category

      if (subCategoryId == '88') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PropertyTaxScreen()));
      } else {
        showMessageToast('Coming soon');
      }
    }*/
    else if (categoryId == '3') {
      // Trade Category

      if (subCategoryId == '11') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdvertisementLicense(
                    title: widget.title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName)));
      } else if (subCategoryId == '10') {

        var applicantJson= {
          'Name of the Service Selected': 'Letter of approval for industry',
          'Service provider': 'Department of Rural Development and Panchayat Raj',
          'Necessary qualification to avail these services': 'Essential citizens of this service',
          'Online Application Fee': 'Rs.50 / - only',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Max Time Line to Provide the Service (Days)': '30 days',
        };
        var serviceJson={
          '1':'Receipt of application & verification of documents',
          '2':'To publish the seven-day objection on the notice board',
          '3':'Check with records if objections come up & take appropriate action & field inspection to present to General Meeting',
          '4':'Action by the Panchayati Development Officer / Secretary as per the resolution of the General Meeting.',
        };
        var documnetJson={
          '1':'Approval letter from fire department',
          '2':'Environmental Disapproval Letter *',
          '3':'Labor Department Disclosure Letter *',
          '4':'Industry Department Permit *',
          '5':'Tax Payment Receipt *',

        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Details required for factory clearance application',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => FactoryClearance(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else if (subCategoryId == '9') {

        var applicantJson= {
          'Name of the Service Selected': 'Application For Trade license',
          'Service provided by': 'Rural Development and Panchayat Raj Department',
          'Eligiblity to get this services': 'Citizens in need of this service',
          'Note': 'E-signing the application is mandatory in this service (be ready with aadhar number); The DigiLocker facility is available (be ready with aadhar number);',
          'Online Application Fee': 'Rs.50 /- only',
          'Fee/Charges to be paid to get the service (Rs.)': 'As Per Panchayath Bye Law',
          'Service is expected to be delivered within (days)': '45 Days',
        };
        var serviceJson={
          '1':'Receiving application from DEO login',
          '2':'Verification of recieved Application & Documents scrutiny in GP Secretary Login',
          '3':'Acceptance of Application in PDO',
          '4':'Issuance of Certificate in PDO login using DSC after stipulated time',
          '5':'Download the issued certificate in the Certificate Download option',
        };
        var documnetJson={
          '1':'Demand extract *',
          '2':'EPIC/Id. Proof/Ration card *',
          '3':'Katha Certificate',
          '4':'Licence Copy *',
          '5':'NOCs from concerned authority (whichever is applicable)',
          '6':'Old Trade License (In case of additional/Modification)',
          '7':'Owner photo *',
          '8':'Property details/Property ID',
          '9':'Rent/Lease Agreement *',
          '10':'RTC/Proof of Site',
          '11':'Tax Paid Receipt *',
        };
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewInstruction( maintitle: widget.title,categoryTitle:'Application Details For Trade license',categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName,applicantJson: applicantJson,serviceJson: serviceJson, documnetJson: documnetJson)));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => BusinessLicense(
        //             title: widget.title,
        //             categoryId: categoryId,
        //             serviceId: subCategoryId,
        //             applicationId: '',
        //             servieName: servieName)));
      } else {
        showMessageToast('Coming soon');
      }
    } else if (categoryId == '1') {
      if (subCategoryId == '1') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PropertyTaxScreen(
                    title: widget.title,
                    categoryId: categoryId,
                    serviceId: subCategoryId,
                    applicationId: '',
                    servieName: servieName)));
      } else {
        showMessageToast('Coming soon');
      }
    } else {
      showMessageToast('Coming soon');
    }
  }

  void checkSubCategoryData() async {
    bool? flag = await checkNetworkConnectivity();
    if (flag!) {
      Future.delayed(Duration.zero, () {
        this.getSubCategory();
      });
    } else {
      displaySubCategory();
    }
  }

  void getSubCategory() async {
    model = await DatabaseOperation.instance.getCategory(widget.categoryId);
    if (model != null) {
      getSubCategoryData(model!.cATEGORYID);
    }
  }

  Future<void> getSubCategoryData(id) async {
    try {
      var data = {'PRE_SERVICE_ID': id};

      var map = (await httpPostMenu('/ajax/getMasterServiceList?service_name=getMstSubServiceDataById', jsonEncode(data)));

      if (map.length > 0 && map["Status"] == 200) {
        List list = jsonDecode(map["Body"]);
        if (list.length > 0) {
          await DatabaseOperation.instance.updateCategoryServiceData(widget.categoryId,map["Body"]);

          displaySubCategory();
        } else {
          showErrorToast('Something went wrong !');
        }
      } else {
        showErrorToast(map["Body"]);
      }
    } on SocketException {
      // Navigator.pop(context);
      print('No Internet connection 😑');
    } on HttpException {
      // Navigator.pop(context);
      print("Couldn't find the post 😱");
    } on FormatException {
      // Navigator.pop(context);
      print("Bad response format 👎");
    }
  }

  void displaySubCategory() async {
    MstAppCategoryModel?  model2 = await DatabaseOperation.instance.getCategory(widget.categoryId);
    if (model2!.service_data_json.isNotEmpty) {
      List list = jsonDecode(model2.service_data_json);
      subCategoryList = list;
      setState(() {

      });

    }
  }

  IconData? getIcons(BuildContext context, String categoryId, String subCategoryId) {
    if (categoryId == '2') {
      // Building Category

      if (subCategoryId == '4') {
      return Icons.invert_colors_off;
      } else if (subCategoryId == '3') {
       return Icons.invert_colors;
      } else if (subCategoryId == '2') {
        return Icons.business_sharp;
      } else if (subCategoryId == '6') {
      return Icons.text_snippet_outlined;
      } else if (subCategoryId == '7') {
       return Icons.folder_shared;
      }else if (subCategoryId == '8') {
        return Icons.folder_shared_outlined;
      }

    } else if (categoryId == '1') {
      if (subCategoryId == '1') {
        return Icons.art_track_sharp;
      }

    }

    else if (categoryId == '4') {
      // Maintenance Category

      if (subCategoryId == '12') {
   return Icons.shower;
      } else if (subCategoryId == '13') {
       return Icons.lightbulb;
      } else if (subCategoryId == '14') {
        return Icons.holiday_village;
      }
    } else if (categoryId == '5') {
      // OtherScreen Category

      if (subCategoryId == '18') {
      return Icons.tv_rounded;
      } else if (subCategoryId == '16') {
       return Icons.featured_play_list;
      } else if (subCategoryId == '15') {
        return Icons.featured_play_list;
      } else if (subCategoryId == '17') {
        return Icons.add_road_outlined;
      }else if (subCategoryId == '25') {
        return Icons.router;
      }
    }
    else if (categoryId == '3') {
      // Trade Category

      if (subCategoryId == '11') {
       return Icons.badge;
      } else if (subCategoryId == '10') {
        return Icons.precision_manufacturing_outlined;
      } else if (subCategoryId == '9') {
       return Icons.business_center;
      }
    }
  }
}
