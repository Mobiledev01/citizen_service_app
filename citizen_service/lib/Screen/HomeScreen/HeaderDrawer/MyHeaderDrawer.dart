import 'package:citizen_service/Utility/Color.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
    as globals;

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20, left: 20),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: 70,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                  child: Icon(
                    Icons.person,
                    color: grayColor,
                    size: 50,
                  ),
                ),
              ),
              Text(
                "Nil Suthar",
                style: TextStyle(color: whiteColor, fontSize: 18),
              ),
              Text(
                "+918153874404",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.edit_sharp,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  showMessageToast('Edit Citizen Profile');
                },
              ))
        ],
      ),
    );
  }
}
