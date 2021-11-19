import 'package:citizen_service/Screen/CategoryScreen/CategoryScreen.dart';
import 'package:citizen_service/Screen/Dashboard/Dashboard.dart';
import 'package:citizen_service/Screen/DownloadMasterScreen/DownloadMasterScreen.dart';
import 'package:citizen_service/Screen/HomeScreen/HeaderDrawer/MyHeaderDrawer.dart';
import 'package:citizen_service/Screen/PropertyTaxScreen/PropertyTaxScreen.dart';
import 'package:citizen_service/Screen/SplashScreen/SplashScreen.dart';
import 'package:citizen_service/Screen/SyncScreen/SyncScreen.dart';
import 'package:citizen_service/SqliteDatabase/Database.dart';
import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Style.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:citizen_service/main.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenOld> {
  var currentPage = DrawerSections.dashboard;

  String lable = 'Home';
  double valueIndicator = 0.0;
  int totalSyncApp = 0;
  int totalUnSyncApp = 0;
  bool indicatorShow = false;
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = CategoryScreen();
    } else if (currentPage == DrawerSections.applications) {
      container = CategoryScreen();
    } else if (currentPage == DrawerSections.applicationsGp) {
      //container = PropertyTaxScreen();
    } else if (currentPage == DrawerSections.status) {
      showMessageToast('Coming Soon..');
    } else if (currentPage == DrawerSections.dashboard) {
      container = Dashboard();
    }else if (currentPage == DrawerSections.language) {
      showMessageToast('Coming Soon language');
    } else {
      showMessageToast('Coming Soon..');
    }

    void choiceAction(String choice){
      if (choice == Constants.download) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DownloadMasterScreen()));
      } else if (choice == Constants.upload) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SyncScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context,'DrawerMenu',lable)),
        backgroundColor:
            globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        actions: [

          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              openInstruction();
            },
          ),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                myDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // shows the list of menu drawer
        children: [
          menuItem(1, getTranslated(context,'DrawerMenu','Home'), Icons.home_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          Divider(),
          menuItem(2, getTranslated(context,'DrawerMenu','Citizen_Service'), Icons.miscellaneous_services_outlined,
              currentPage == DrawerSections.home ? true : false),
          Divider(),
          menuItem(3, getTranslated(context,'DrawerMenu','Grievance'), Icons.assignment_outlined,
              currentPage == DrawerSections.applications ? true : false),
          Divider(),
          menuItem(4, getTranslated(context,'DrawerMenu','Tax_Payment'), Icons.payment_outlined,
              currentPage == DrawerSections.applicationsGp ? true : false),
          Divider(),
          menuItem(5, getTranslated(context,'DrawerMenu','Feedback_Suggestion'), Icons.feedback_outlined,
              currentPage == DrawerSections.status ? true : false),
          Divider(),
          menuItem(7, getTranslated(context,'DrawerMenu','Language'), Icons.language,
              currentPage == DrawerSections.language ? true : false),
          Divider(),
          menuItem(6, getTranslated(context,'DrawerMenu','Sign_Out'), Icons.logout_outlined,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
              setState(() {
                lable = 'Home';
              });
            }
            if (id == 2) {
              currentPage = DrawerSections.home;
              setState(() {
                lable = 'Citizen_Service';
              });
            } else if (id == 3) {
              currentPage = DrawerSections.applications;
              setState(() {
                lable = 'Grievance';
              });
            } else if (id == 4) {
              currentPage = DrawerSections.applicationsGp;
              setState(() {
                lable = 'Tax_Payment';
              });
            } else if (id == 5) {
              currentPage = DrawerSections.status;
              setState(() {
                lable = 'Feedback_Suggestion';
              });
            } else if (id == 6) {
              logOutProcess();
            }else if (id == 7) {
              changeLanguage();
            }

            // else if (id == 4) {
            //   currentPage = DrawerSections.reports;
            // }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
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
          content: Text("Are You Sure To Logout ?"),
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
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
          ],
        );
      },
    );
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
                            'Instructions',
                            style: blackBoldText16,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        ExpansionTile(
                          backgroundColor: lightBlueColor,
                          title: Text(
                            'Details required for permit application',
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: lightGrayColor,
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
                        Divider(),
                        ExpansionTile(
                          backgroundColor: lightBlueColor,
                          title: Text(
                            'List of Documents',
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: lightGrayColor,
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
                        Divider(),
                        ExpansionTile(
                          backgroundColor: lightBlueColor,
                          title: Text(
                            'Fees Structure',
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: lightGrayColor,
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
                        Divider(),
                        ExpansionTile(
                          backgroundColor: lightBlueColor,
                          title: Text(
                            'Service Process',
                            style: blackNormalText16,
                            textAlign: TextAlign.center,
                          ),
                          children: [
                            Container(
                              color: lightGrayColor,
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

  void changeLanguage() async {

    String? language = await getPreference('language');
    setState(() {
      dropdownValue =language!;
    });


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
          actions: [
            okButton,
            cancelButton
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetPadding: EdgeInsets.all(20),
          backgroundColor: whiteColor,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                child:
                DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
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
                )
              );
            },
          ),
        );
      },
    );

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
}

enum DrawerSections {
  home,
  dashboard,
  applications,
  applicationsGp,
  status,
  language,
  logout,
}

class Constants {
  static const String download = 'Download Master';
  static const String upload = 'Upload Data';

  static const List<String> choices = <String>[download,upload];
}