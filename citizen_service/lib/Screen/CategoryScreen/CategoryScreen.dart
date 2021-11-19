import 'dart:convert';
import 'dart:io';
import 'package:citizen_service/HttpCalls/HttpCall.dart';
import 'package:citizen_service/Model/DropDownModel.dart';
import 'package:citizen_service/Model/MstAppCategoryModel.dart';
import 'package:citizen_service/Screen/CategoryScreen/SubCategoryScreen.dart';
import 'package:citizen_service/Screen/DownloadMasterScreen/DownloadMasterScreen.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Loading.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>  with TickerProviderStateMixin{
  AnimationController? animationController;
  String categorySelectValue = '';
  String serviceSelectValue = '';

  DropDownModal? categorySelect;
  DropDownModal? serviceSelect;

  List<MstAppCategoryModel> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    checkDownloadAllMasters();
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    checkCategoryData();

  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            getTranslated(context,'DrawerMenu','Citizen_Service'),
            textAlign: TextAlign.center,
          ),
        ),

        backgroundColor:globals.isTrainingMode ? testModePrimaryColor : primaryColor,

      ),
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
                      : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 0),
                          physics: BouncingScrollPhysics(),
                          primary: true,
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            final int count = categoryList.length;
                            final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return _buildListView(context, index,animation: animation,
                              animationController: animationController,);
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index, {required Animation<double> animation, AnimationController? animationController}) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastOutSlowIn)),
              child: GestureDetector(
                onTap: () {
                  print(categoryList[index].cATEGORYID);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SubCategoryScreen(title: categoryList[index].aPPLICATIONNAME, categoryId: categoryList[index].cATEGORYID)));
                },
                child: Card(
                  color: globals.isTrainingMode ? testModePrimaryColor : whiteColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 5,

                  child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                      child: Icon(
                        getIcons(index),
                        size: 40,
                        color: Colors.black45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(categoryList[index].aPPLICATIONNAME,
                            textAlign: TextAlign.center,
                            style: blackBoldText16),
                      ),
                    ),
                  ],
                ),
                ),
              ),

            );

        });
  }

  Future<void> getCategoryDropDown() async {
    try {
      categoryList.clear();
      var data = {};
      // showDialogWithLoad(context);
      var map = (await httpPostMenu('/ajax/getMasterServiceList?service_name=getMstServiceData', jsonEncode(data)));

      if (map.length > 0 && map["Status"] == 200) {
        List list = jsonDecode(map["Body"]);
        if (list.length > 0) {
          await DatabaseOperation.instance.deleteCategory();
          for (var i = 0; i < list.length; i++) {
            MstAppCategoryModel model = new MstAppCategoryModel(
                id: null,
                cATEGORYID: list[i]['DATA_ID'],
                aPPLICATIONNAME: list[i]['SERVICE_TITLE'],
                service_data_json: '');

            await DatabaseOperation.instance.insertCategory(model);
          }
          displayCategory();
        } else {
          showErrorToast('Something went wrong !');
        }
      } else {
        // Navigator.pop(context);
        showErrorToast('Something went wrong !');
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

  void displayCategory() async {
    categoryList = await DatabaseOperation.instance.getAllCategory();
    setState(() {    });
  }

  IconData? getIcons(int index) {
    if(categoryList[index].cATEGORYID == "2" ){
      return Icons.business_sharp;
    }
    else if(categoryList[index].cATEGORYID == "1" ){
      return Icons.article;
    }
    else if(categoryList[index].cATEGORYID == "3" ){
      return Icons.assessment;
    }
    else if(categoryList[index].cATEGORYID == "4" ){
      return Icons.engineering;
    }
    else if(categoryList[index].cATEGORYID == "5" ){
      return Icons.other_houses;
    }
  }
  Future<void> checkDownloadAllMasters() async {
    String? isDownloadDistrict = await getPreference('isDownloadDistrict');
    String? isDownloadTaluka = await getPreference('isDownloadTaluka');
    String? isDownloadGpachayat = await getPreference('isDownloadGramPanchayat');
    String? isDownloadVillage = await getPreference('isDownloadVillage');
    String? isDownloadAll = await getPreference('isDownloadAllMasters');
    //print('shared value'+isDownload_district.toString());
    if (isDownloadDistrict == null || isDownloadDistrict == 'N' || isDownloadDistrict.isEmpty || isDownloadTaluka == null ||
        isDownloadTaluka == 'N' || isDownloadTaluka.isEmpty || isDownloadGpachayat == null || isDownloadGpachayat == 'N' || isDownloadGpachayat.isEmpty ||
        isDownloadVillage == null || isDownloadVillage == 'N' || isDownloadVillage.isEmpty || isDownloadAll == null || isDownloadAll == 'N' || isDownloadAll.isEmpty) {
      Future.delayed(Duration.zero, () => showDownloadMasters(context));
    }
  }
  showDownloadMasters(BuildContext context) async {
    Widget okButton = TextButton(
      child: Text('Ok', style: whiteNormalText14),
      style: cancelButtonBlueStyle,
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DownloadMasterScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert1 = AlertDialog(
      title: Container(
          color: primaryColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Download All Masters",
                style: whiteBoldText18,
              ),
            ),
          )),
      titlePadding: const EdgeInsets.all(10),
      content: Container(
        height: 40,
        child: Text("First Download All Masters before filling Application"),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
        child:alert1,
        );
      },
    );
  }

  void checkCategoryData() async {
    bool? flag = await checkNetworkConnectivity();
    if (flag!) {
      Future.delayed(Duration.zero, () {
        this.getCategoryDropDown();
      });
    } else {
      displayCategory();
    }
  }

}
