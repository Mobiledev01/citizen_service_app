import 'package:citizen_service/Screen/SplashScreen/SplashScreen.dart';
import 'package:citizen_service/Screen/UpdateProfile/UpdateProfile.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/main.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

class HomeDrawer extends StatefulWidget {
  HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  String dropdownValue = 'English';

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.dashboard,
        labelName: 'Home',
        icon: Icon(Icons.home_outlined),
      ),
      DrawerList(
        index: DrawerIndex.home,
        labelName: 'Citizen_Service',
        icon: Icon(Icons.miscellaneous_services_outlined),
      ),
      DrawerList(
        index: DrawerIndex.grievance,
        labelName: 'Grievance',
        icon: Icon(Icons.assignment_outlined),
      ),
      DrawerList(
        index: DrawerIndex.taxpayment,
        labelName: 'Tax_Payment',
        icon: Icon(Icons.payment_outlined),
      ),
      DrawerList(
        index: DrawerIndex.status,
        labelName: 'Feedback_Suggestion',
        icon: Icon(Icons.feedback_outlined),
      ),
      DrawerList(
        index: DrawerIndex.language,
        labelName: 'Language',
        icon: Icon(Icons.language),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(

                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset('assets/userImage.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 0),
                            child: IconButton(onPressed: (){

                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                            }, icon: Icon(Icons.edit_sharp)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 4),
                          child: Text(
                            'Nil Suthar',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, left: 4),
                          child: Text(
                            globals.loginSessionModel!.emailId!,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, left: 4),
                          child: Text(
                            '+91 '+globals.loginSessionModel!.mobileNo!,
                            style: TextStyle(
                              color: grayColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  getTranslated(context,'DrawerMenu','Sign_Out'),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  logOutProcess();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void logOutProcess() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure to logout ?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () async {
                await DatabaseOperation.instance.cleanDatabase();
                addPreference('isDownloadAllMasters', 'N');
                addPreference('isDownloadDistrict', 'N');
                addPreference('isDownloadTaluka', 'N');
                addPreference('isDownloadGramPanchayat', 'N');
                addPreference('isDownloadVillage', 'N');
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
       splashColor: Colors.grey.withOpacity(0.1),
       highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? primaryColor
                                  : nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? primaryColor
                              : nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                   getTranslated(context,'DrawerMenu',listData.labelName),
                    style: TextStyle(
                     fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? primaryColor
                          : nearlyBlack
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController!.value - 1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.3),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    if (DrawerIndex.language == indexScreen) {
      changeLanguage();
    } else {
      widget.callBackIndex!(indexScreen);
    }
  }

  void setLanguage(String lang) {
    Locale _temp;
    switch (lang) {
      case 'English':
        _temp = Locale('en', 'US');
        break;
      case 'Kannada':
        _temp = Locale('kn', 'IN');
        break;
      default:
        _temp = Locale('en', 'US');
        break;
    }

    MyApp.setLocale(context, _temp);
    addPreference('language', lang);
  }

  void changeLanguage() async {
    String? language = await getPreference('language');

    if (language != null && language.isNotEmpty) {
      setState(() {
        dropdownValue = language;
      });
    }

    Widget okButton = TextButton(
      child: Text('Change Language'),
      onPressed: () async {
        setLanguage(dropdownValue);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: Text(cancel),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Language"),
          actions: [okButton, cancelButton],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetPadding: EdgeInsets.all(20),
          backgroundColor: whiteColor,
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
                child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['English', 'Kannada']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ));
          }),
        );
      },
    );
  }
}

enum DrawerIndex {
  home,
  dashboard,
  grievance,
  taxpayment,
  language,
  status,
  logout,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
