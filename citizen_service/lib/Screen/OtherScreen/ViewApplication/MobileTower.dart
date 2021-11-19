import 'package:flutter/cupertino.dart';

class MobileTower extends StatefulWidget {
  final String categoryId, serviceId, title, applicationId, servieName;
  const MobileTower({Key? key , required this.title,
    required this.categoryId,
    required this.serviceId,
    required this.applicationId,
    required this.servieName}) : super(key: key);

  @override
  _MobileTowerState createState() => _MobileTowerState();
}

class _MobileTowerState extends State<MobileTower> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
