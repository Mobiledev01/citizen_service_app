import 'package:flutter/material.dart';

class GpApplicationScreen extends StatefulWidget {
  const GpApplicationScreen({Key? key}) : super(key: key);

  @override
  _GpApplicationScreenState createState() => _GpApplicationScreenState();
}

class _GpApplicationScreenState extends State<GpApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15, 20, 0),
            child: Text('GP Application'),
          ),
        ),
      ),
    );
  }
}
