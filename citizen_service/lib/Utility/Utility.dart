import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Localization/demo_localization.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Style.dart';

final DateFormat formatter = DateFormat('dd/MM/yyyy');

// getText(str) {
//   if (str == null || str.toString().isEmpty) {
//     return '';
//   } else {
//     return str;
//   }
// }

String getTranslated(BuildContext context,String parent,String child){
  return DemoLocalization.of(context)!.getTranslatedValue(parent,child);
}


getCurrentDateUsingFormatter(formatStr) {
  var now = new DateTime.now();
  var formatter = new DateFormat(formatStr);
  String formattedDate = formatter.format(now);
  return formattedDate; // 2016-01-25
}

getDateUsingForDate(String dateTimeString,String original,String convert){
  DateFormat originalFormatter = DateFormat(convert);
  DateFormat formatter = DateFormat(original);
  return originalFormatter.format(formatter.parse(dateTimeString));
}


showSuccessToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showPendingToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 4,
    backgroundColor: Colors.orangeAccent,
    textColor: Colors.black,
    fontSize: 20.0,
  );
}

showErrorToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showMessageToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    // backgroundColor: Colors.black,
    // textColor: Colors.white,
    fontSize: 16.0,
  );
}

addPreference(key, data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, data);
}

Future<String?> getPreference(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(key)) {
    String? stringValue = prefs.getString(key);
    return stringValue;
  } else {
    return "";
  }
}

Future<bool?> checkNetworkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

getIcon(index) {
  if (index.toString() == '2') {
    return Icons.calculate_outlined;
  } else if (index.toString() == '1') {
    return Icons.science_outlined;
  } else if (index.toString() == '4') {
    return Icons.quiz_outlined;
  } else if (index.toString() == '3') {
    return Icons.sports_soccer_outlined;
  } else {
    return Icons.event_note_outlined;
  }
}

getColor(int index) {
  if (index % 4 == 0) {
    return Colors.deepOrange[400];
  } else if (index % 4 == 1) {
    return Colors.deepPurpleAccent[400];
  } else if (index % 4 == 2) {
    return Colors.cyan[400];
  } else if (index % 4 == 3) {
    return Colors.red[400];
  } else {
    return Colors.green[400];
  }
}

showDialogWithLoad(context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SpinKitCircle(
                        size: 80.0,
                        color: primaryColor,
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

selectDate(BuildContext context, DateTime selectedDate, bool rFlag) async {
  ////var date = await selectDate(context, selectedDate);

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2021),
    lastDate: DateTime(2025),
    cancelText: 'Cancel',
    confirmText: 'Ok',
    // selectableDayPredicate: _decideWhichDayToEnable,
  );

  if (picked != null && picked != selectedDate){
    return formatter.format(picked).toString();
  } else if(rFlag){
    return formatter.format(selectedDate).toString();
  }else{
    return '';
  }
}

selectDobDate(BuildContext context, DateTime selectedDate, bool rFlag) async {
  ////var date = await selectDate(context, selectedDate);

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    cancelText: 'Cancel',
    confirmText: 'Ok',
    // selectableDayPredicate: _decideWhichDayToEnable,
  );

  if (picked != null && picked != selectedDate){
    return formatter.format(picked).toString();
  } else if(rFlag){
    return formatter.format(selectedDate).toString();
  }else{
    return '';
  }
}

getTextFromLang(text) {
  String lang = "Kn";

  if (lang == 'Kn') {
    return "$text" + "Kn";
  } else {
    return text;
  }
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

// for one option alert dialog

// showAlertDialog(BuildContext context, Function okBtnPress) {
//
//   // set up the button
//   Widget okButton = TextButton(
//     child: Text("OK"),
//     onPressed: () {
//       okBtnPress('sd');
//     },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("My title"),
//     content: Text("This is my message."),
//     actions: [
//       okButton,
//     ],
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }


//kasim start


Widget labelField (String label){
  return RichText(
    text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: label,
          style: formLabelStyle),
      TextSpan(
          text: " *",
          style:TextStyle(
              color: redColor
          ),),
    ]),
  );
}



//kasim end