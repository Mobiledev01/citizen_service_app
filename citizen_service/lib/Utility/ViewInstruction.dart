import 'dart:convert';

import 'package:citizen_service/Screen/BuildingScreen/BuildingLicenseScreen.dart';
import 'package:citizen_service/Screen/BuildingScreen/DisWaterConnection.dart';
import 'package:citizen_service/Screen/BuildingScreen/WaterConnection.dart';
import 'package:citizen_service/Screen/Maintenance/DrinkingWater.dart';
import 'package:citizen_service/Screen/Maintenance/Streetlight.dart';
import 'package:citizen_service/Screen/Maintenance/VillageSanitation.dart';
import 'package:citizen_service/Screen/OtherScreen/IssuanceOfNocEscoms.dart';
import 'package:citizen_service/Screen/OtherScreen/RoadCuttingPermission.dart';
import 'package:citizen_service/Screen/TradeScreen/BusinessLicense.dart';
import 'package:citizen_service/Screen/TradeScreen/FactoryClearance.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:flutter/material.dart';

import 'Color.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

import 'Style.dart';

class ViewInstruction extends StatefulWidget {

  final String  categoryId, serviceId, applicationId, servieName,maintitle,categoryTitle;
  var applicantJson,serviceJson,documnetJson;
  ViewInstruction(
      {Key? key,
        required this.categoryId,required this.serviceId, required this.applicationId,required this.servieName, required this.maintitle,required this.categoryTitle,required this.applicantJson,required this.documnetJson,required this.serviceJson})
      : super(key: key);

  @override
  _ViewInstruction createState() => _ViewInstruction();
}
class _ViewInstruction extends State<ViewInstruction> {
  var applicantJson,serviceJson,documentJson;
  final _controller = new PageController();
  final ScrollController _scrollController = ScrollController();
  static const _kDuration = const Duration(milliseconds: 800);
  static const _kCurve = Curves.linearToEaseOut;
  String next_label='Next';
  var PageNo,applicantJson_length;
  late Map<String, dynamic> applicant_json;
  late Map<String, dynamic> service_json;
  late Map<String, dynamic> document_json;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    applicantJson=widget.applicantJson;
    serviceJson=widget.serviceJson;
    if(widget.documnetJson!=null)
      {
        documentJson=widget.documnetJson;
        document_json=Map<String, dynamic>.from(documentJson);
      }

    applicant_json= Map<String, dynamic>.from(applicantJson);
    service_json=Map<String, dynamic>.from(serviceJson);

    applicantJson_length=applicant_json.length;
    for(var j=0 ; j < applicantJson_length ; j++)
      {
        print('key : ' + applicant_json.keys.toList()[j].toString());
        print('values :' + applicant_json.values.toList()[j].toString());
      }
    print(applicant_json.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> _pages = [
      AppDetailsWidget(),
      if(documentJson !=null)
        DocumentList(),
      ServiceProcess()
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: globals.isTrainingMode ? testModePrimaryColor : primaryColor,
          title: Text(widget.categoryTitle, style: whiteBoldText16)),
      body: Column(
        children: <Widget>[
          Flexible(
            child: PageView(
              children: _pages,
              controller: _controller,
              onPageChanged: _onPageViewChange,
            ),
          ),
          Container(
            //color: whiteColor,
            //margin: EdgeInsets.fromLTRB(0, 5, 0,0),
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 9,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: submitButtonBlueStyle,
                  child: Text(next_label, style: whiteNormalText14),
                  onPressed: () {
                    _controller.nextPage(duration: _kDuration, curve: _kCurve);
                    //print('tital pages'+_pages.length.toString());
                    if (PageNo == _pages.length - 1) {
                      if (widget.categoryId == '2') {
                        // Building Category
                        if (widget.serviceId == '4') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DisconnectingWaterConnection(
                                          title: widget.maintitle,
                                          categoryId: widget.categoryId,
                                          serviceId: widget.serviceId,
                                          applicationId: '',
                                          servieName: widget.servieName)));
                        } else if (widget.serviceId == '3') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WaterConnection(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        } else if (widget.serviceId == '2') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuildingLicenseScreen(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        }
                      } else if (widget.categoryId == '4') {
                        // Maintenance Category
                        if (widget.serviceId == '12') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrinkingWater(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        } else if (widget.serviceId == '13') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Streetlight(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        } else if (widget.serviceId == '14') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VillageSanitation(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        }
                      } else if (widget.categoryId == '5') {
                        // OtherScreen Category
                        if (widget.serviceId == '16') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IssuanceOfNocEscoms(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        } else if (widget.serviceId == '17') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoadCuttingPermission(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        }
                      } else if (widget.categoryId == '3') {
                        // Trade Category
                        if (widget.serviceId == '10') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FactoryClearance(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        } else if (widget.serviceId == '9') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusinessLicense(
                                      title: widget.maintitle,
                                      categoryId: widget.categoryId,
                                      serviceId: widget.serviceId,
                                      applicationId: '',
                                      servieName: widget.servieName)));
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget AppDetailsWidget()
{
  return Container(
    child:SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Divider(thickness: 1),
            Container(
             // color: grayColor.withOpacity(0.5),
             padding: EdgeInsets.all(10),

              child: Text(widget.categoryTitle,
                          style: blackBoldText18,
                          textAlign: TextAlign.center,
              ),
            ),
            Divider(thickness: 1),
            Table(
                         children: [
                                for(var  i= 0; i < applicant_json.length ; i++)
                                  TableRow(
                                      children: [
                                          TableCell(
                                          child:Padding(
                                          padding: const EdgeInsets.all(8.0),
                                              child:Text(applicant_json.keys.toList()[i].toString(),style: blackNormalText16,),),),

                                        TableCell(
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:Text(applicant_json.values.toList()[i].toString(),style: blackNormalText16,),),),
                                      ]
                                  ),
                        ],
            ),
          ],
        ),
      ),
    ),
  );
}
  Widget ServiceProcess()
  {
      return Container(
        child:SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               // Divider(thickness: 1),
                Container(
                  // color: grayColor.withOpacity(0.5),
                  padding: EdgeInsets.all(10),

                  child: Text('Service Process',
                    style: blackBoldText18,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(thickness: 1),
                for(var j =0 ; j < service_json.length ; j++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(service_json.keys.toList()[j].toString()+'.',style: blackNormalText16)),
                       Expanded(

                              child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(service_json.values.toList()[j].toString(),style: blackNormalText16)),
                            ),

                      ],
                    ),
                Divider(thickness: 1),
                Container(
                  // color: grayColor.withOpacity(0.5),
                  padding: EdgeInsets.all(10),
                  child: Padding(
                          padding: EdgeInsets.all(5) ,
                          child: Text('Before proceeding to enter the application form please be ready with scanned copies of the above documents and for online payment',
                            style: redNormalText18,textAlign: TextAlign.justify,),
                        ),

                ),

            ],
            ),
          ),
        ),
        );
  }
  Widget DocumentList()
  {
    return Container(
      child:SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Divider(thickness: 1),
              Container(
                // color: grayColor.withOpacity(0.5),
                padding: EdgeInsets.all(15),

                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8) ,
                        child: Text('Scanned documents to be uploaded to get this Service',
                        style: blackNormalText18,),
                      ),
                      Text('* indicates mandatory document to be uploaded ',
                        style: redNormalText18,),
                  ],
                  ),
                ),
              ),
              Divider(thickness: 1),
              Container(
                // color: grayColor.withOpacity(0.5),
                padding: EdgeInsets.all(10),

                child: Text('List Of Document',
                  style: blackBoldText18,
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(thickness: 1),
              for(var j =0 ; j < document_json.length ; j++)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(document_json.keys.toList()[j].toString()+'.',style: blackNormalText16)),
                        Expanded(

                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Text(document_json.values.toList()[j].toString(),style: blackNormalText16)),
                        ),

                      ],
                    ),
                    Divider(thickness: 1),
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
  _onPageViewChange(int page) {
    setState(() {
      PageNo=page;
     //print("current page: " + page.toString());
    });
    // int previousPage = page;
    // if(page != 0) previousPage--;
    // else previousPage = 2;
    // print("Previous page: $previousPage");
  }
}