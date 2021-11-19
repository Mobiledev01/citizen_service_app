import 'dart:convert';
import 'dart:io';
import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Screen/BuildingScreen/BuildingLicenseScreen.dart';
import 'package:citizen_service/Screen/BuildingScreen/DisWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/Form%209,11/Mutation.dart';
import 'package:citizen_service/Screen/BuildingScreen/Form9.dart';
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
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Loading.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  String categorySelectValue = '';
  String serviceSelectValue = '';

  DropDownModal? categorySelect;
  DropDownModal? serviceSelect;

  List<DropDownModal> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.getCategoryDropDown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  service_categories.toUpperCase(),
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: categoryList.isEmpty
                      ? Loading()
                      : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    primary: true,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return _buildListView(context, index);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    return Card(
        elevation: 0,
        color: graysub,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(60),
                bottomLeft: Radius.circular(10))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color:
                globals.isTrainingMode ? testModePrimaryColor : primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60))),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(categoryList[index].title,
                        textAlign: TextAlign.center, style: whiteBoldText16),

                  ),
                ),
              ),


              /* Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(categoryList[index].title,
                    textAlign: TextAlign.center, style: blackBoldText16),
              ),*/
              FutureBuilder(
                future: getSubCategoryData(categoryList[index].id),
                builder: (context, snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data.toString().isNotEmpty) {
                    var jsonData = jsonDecode(snapshot.data.toString()) as List;
                    List<DropDownModal> list = jsonData
                        .map((tagJson) => DropDownModal.fromJson(tagJson))
                        .toList();
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: GridView.count(
                            primary: false,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 1,
                            physics: PageScrollPhysics(),
                            children: List.generate(list.length, (indexSub) {
                              return _buildListSubView(context, list[indexSub],
                                  categoryList[index].id);
                            })),
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('No Menu Found !')));
                  }
                },
              )
            ]));
  }

  Widget _buildListSubView(
      BuildContext context, DropDownModal downModal, String categoryId) {
    return GestureDetector(
      onTap: () {
        // navigationMenu(context, categoryId, downModal.id, downModal.title);
      },
      child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: new BorderSide(color: primaryColor, width: 1),
          ),
          child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.apps_outlined,
                    size: 35,
                    color: grayColor,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(downModal.title,
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                  ),
                ],
              ))),
    );
  }

  Future<void> getCategoryDropDown() async {
    try {
      categoryList.clear();
      var data = {};
      // showDialogWithLoad(context);
      var map = (await httpPostDropDownMethod(
          '/ajax/getMasterServiceList?service_name=getMstServiceData',
          jsonEncode(data)));

      if (map.length > 0 && map["Status"] == 200) {
        // Navigator.pop(context);
        var jsonData = jsonDecode(map["Body"]) as List;
        List<DropDownModal> list =
        jsonData.map((tagJson) => DropDownModal.fromJson(tagJson)).toList();

        if (list.length > 0) {
          setState(() {
            categoryList = list;
            print(categoryList.length);
          });
        } else {
          showErrorToast('Something went wrong !');
        }
      } else {
        // Navigator.pop(context);
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

  Future<String?> getSubCategoryData(id) async {
    try {
      var data = {'category_id': id};

      var map = (await httpPostDropDownMethod(
          '/ajax/getMasterServiceList?service_name=getSubCategoryData',
          jsonEncode(data)));

      if (map.length > 0 && map["Status"] == 200) {
        return map["Body"];
      } else {
        // Navigator.pop(context);
        return '';
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

  // void navigationMenu(BuildContext context, String categoryId,
  //     String subCategoryId, String title) {
  //   print(categoryId);
  //   print(subCategoryId);
  //
  //   if (categoryId == '3') {
  //     // Building Category
  //
  //     if (subCategoryId == '75') {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => DisconnectingWaterConnection(
  //                   title: title,
  //                   categoryId: categoryId,
  //                   serviceId: subCategoryId,
  //                   applicationId: ''
  //               )));
  //     } else if (subCategoryId == '74') {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => WaterConnection(
  //                   title: title,
  //                   categoryId: categoryId,
  //                   serviceId: subCategoryId,
  //                   applicationId: '')));
  //     } else if (subCategoryId == '45') {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => BuildingLicenseScreen(
  //                   title: title,
  //                   categoryId: categoryId,
  //                   serviceId: subCategoryId,
  //                   applicationId: '')));
  //     } else if (subCategoryId == '77') {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Form9()));
  //     } else if (subCategoryId == '76') {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Mutation()));
  //     } else {
  //       showMessageToast('Coming soon');
  //     }
  //   } else if (categoryId == '5') {
  //     // Maintenance Category
  //
  //     if (subCategoryId == '81') {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => DrinkingWater(title: title,
  //           categoryId: categoryId,
  //           serviceId: subCategoryId,
  //           applicationId: '')));
  //     } else if (subCategoryId == '82') {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Streetlight(
  //           title: title,
  //           categoryId: categoryId,
  //           serviceId: subCategoryId,
  //           applicationId: ''
  //       )));
  //     } else if (subCategoryId == '83') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => VillageSanitation(
  //               title: title,
  //               categoryId: categoryId,
  //               serviceId: subCategoryId,
  //               applicationId: ''
  //           )));
  //     } else {
  //       showMessageToast('Coming soon');
  //     }
  //   } else if (categoryId == '6') {
  //     // OtherScreen Category
  //
  //     if (subCategoryId == '85') {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => Entertainmentlicense(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else if (subCategoryId == '87') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => IssuanceOfNocEscoms(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else if (subCategoryId == '86') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => IssuanceOfRecords()));
  //     } else if (subCategoryId == '84') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => RoadCuttingPermission(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else {
  //       showMessageToast('Coming soon');
  //     }
  //   } else if (categoryId == '7') {
  //     // Property Category
  //
  //     if (subCategoryId == '88') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => PropertyTaxScreen()));
  //     } else {
  //       showMessageToast('Coming soon');
  //     }
  //   } else if (categoryId == '4') {
  //     // Trade Category
  //
  //     if (subCategoryId == '80') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => AdvertisementLicense(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else if (subCategoryId == '79') {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => FactoryClearance(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else if (subCategoryId == '78') {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => BusinessLicense(title: title,categoryId: categoryId,serviceId: subCategoryId,applicationId: '')));
  //     } else {
  //       showMessageToast('Coming soon');
  //     }
  //   } else {
  //     showMessageToast('Coming soon');
  //   }
  // }
}
