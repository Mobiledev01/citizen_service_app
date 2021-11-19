import 'package:citizen_service/Utility/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: SpinKitCircle(
          size: 50.0,
          color: primaryColor,
        ),
      ),
    );
  }
}
