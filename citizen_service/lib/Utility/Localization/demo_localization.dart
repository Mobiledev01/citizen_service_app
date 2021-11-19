import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DemoLocalization {

  final Locale local;

  DemoLocalization(this.local);

  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  // Map<String,String> _localizedValue = new Map<String,String>();
  var jsonData ;

  Future load() async {
    String jsonStringValue = await rootBundle.loadString('lib/lang/${local.languageCode}.json');

    // Map<String,dynamic> mappedJson = json.decode(jsonStringValue);
    // _localizedValue = mappedJson.map((key, value) => MapEntry(key, value.toString()));
    jsonData  = json.decode(jsonStringValue);
    // print(ppedJson['Menu']['Home']);
  }

  String getTranslatedValue(String parent,String child) {
    // if(_localizedValue != null && _localizedValue![key] != null){
    return jsonData[parent][child].toString();
    // }else{
    //   return '';
    // }
    //
    // return  _localizedValue != null && _localizedValue[key] != null ? 'key' : _localizedValue[key]  ;
  }

  static const LocalizationsDelegate<DemoLocalization> delegate = DemoLocalizationsDelegate();
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalization> {

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','kn'].contains(locale.languageCode);
  }


  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization demoLocalization = new DemoLocalization(locale);
    await demoLocalization.load();
    return demoLocalization;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}