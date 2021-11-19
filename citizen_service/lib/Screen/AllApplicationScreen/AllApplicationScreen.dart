import 'package:flutter/material.dart';

class AllApplicationScreen extends StatefulWidget {
  const AllApplicationScreen({Key? key}) : super(key: key);

  @override
  _AllApplicationScreenState createState() => _AllApplicationScreenState();
}

class _AllApplicationScreenState extends State<AllApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15, 20, 0),
            child: Text('Application'),

          ),
        ),
      ),
    );
  }
}
