import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'Color.dart';
import 'package:citizen_service/GlobalsVariable/GlobalsVariable.dart'
as globals;

import 'Style.dart';


class ViewImage extends StatefulWidget {
  String filepath = '';
  String filename = '';

  ViewImage({required this.filepath, required this.filename});

  @override
  _ViewImage createState() => _ViewImage();
}
class _ViewImage extends State<ViewImage> {
  String filepath='';
  String filename = '';
  late PDFViewController _controller ;
  final pageno = TextEditingController();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.filepath.isNotEmpty && widget.filename.isNotEmpty)
      {
        filepath=widget.filepath;
        filename=widget.filename;
      }
  }

  @override
  Widget build(BuildContext context) {

    final text='${currentPage!+1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(filename,style: whiteBoldText16,overflow: TextOverflow.ellipsis),
        leading:IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor:
        globals.isTrainingMode ? testModePrimaryColor : primaryColor,
        actions: filepath.contains('pdf')
        ? [
          Center(
            child:Text(text,style: whiteBoldText16),

          ),
          IconButton(
            icon: Icon(Icons.chevron_left,color: whiteColor,size: 32,),
            onPressed: (){
              final page= currentPage == 0 ? pages : currentPage! - 1;
              _controller.setPage(page!);
            }
            ,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right,color: whiteColor,size: 32,),
            onPressed: (){
              final page= currentPage == pages! - 1 ? 0 : currentPage! + 1;
              _controller.setPage(page);
            }

          ),
          ] : null

      ),
    body:filepath.contains('pdf') ? showPdf() : showImage(),
    );
  }
  Widget showImage() {
   return Center(
      child: InteractiveViewer(
        panEnabled: true,
        // Set it to false
        boundaryMargin: EdgeInsets.all(20),
        minScale: 0.1,
        maxScale: 1.6,
        child: Image.file(File(filepath),
          // fit: BoxFit.fill,
        ),
      ),
   );
  }
  Widget showPdf() {
    return Stack(
        children: <Widget>[
          PDFView(
            filePath: filepath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (_pages) {
              setState(() {
                this.pages = _pages;
                this.isReady = true;
                print('total :${pages}');
              });
            },
            onError: (error) {
              setState(() {
                this.errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                this.errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              setState(() {
                this._controller = pdfViewController;
              });
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                this.currentPage = page;
              });
            },

          ),
           errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          ),
          // if set to true the link is handled in flutter
        ],

    );

  }

}
