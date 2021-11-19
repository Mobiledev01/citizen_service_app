import 'package:citizen_service/Screen/splashScreen/SplashScreen.dart';
import 'package:citizen_service/Utility/Localization/demo_localization.dart';
import 'package:citizen_service/Utility/String.dart';
import 'package:citizen_service/Utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  static void setLocale(BuildContext context, Locale temp) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(temp);
  }

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  @override
  void didChangeDependencies() async {
    String? language = await getPreference('language');
    if (language != null && language.isNotEmpty && language == 'Kannada') {
      setState(() {
        _locale = Locale('kn', 'IN');
      });
    } else {
      setState(() {
        _locale = Locale('en', 'US');
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: panchatantra,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('kn', 'IN'), // Spanish, no country code
      ],
      locale: _locale,
      localizationsDelegates: [
        DemoLocalization.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales,) {
        for (var loc in supportedLocales) {
          if (loc.languageCode == locale!.languageCode &&
              loc.countryCode == locale.countryCode) {
            return locale;
          }
        }
        return supportedLocales.first;

      },
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }

  void setLocale(Locale temp) {
    setState(() {
      _locale =temp;
    });
  }
}
