import 'package:flutter/material.dart';

class ApplicationStatusScreen extends StatefulWidget {
  const ApplicationStatusScreen({Key? key}) : super(key: key);

  @override
  _ApplicationStatusScreenState createState() => _ApplicationStatusScreenState();
}

class _ApplicationStatusScreenState extends State<ApplicationStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15, 20, 0),
            child: Text('Application Status'),

          ),
        ),
      ),
    );
  }
}
