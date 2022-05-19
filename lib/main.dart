import 'package:counting_room/pages/coming_page.dart';
import 'package:counting_room/pages/filter_page.dart';
import 'package:counting_room/pages/home_page.dart';
import 'package:counting_room/pages/info_in_date.dart';
import 'package:counting_room/pages/my_consumption.dart';
import 'package:counting_room/pages/own.dart';
import 'package:counting_room/pages/reference.dart';
import 'package:counting_room/pages/translation.dart';
import 'package:counting_room/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/auth.dart';
import 'pages/delete_own.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ru', ''),
      ],
      theme: ThemeData(

        // textTheme: GoogleFonts.manropeTextTheme(),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(
            Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Auth(),
        'HomePage': (context) => HomePage(),
        'MyComing': (context) => MyComing(),
        'MyConsumption': (context) => MyConsumption(),
        'Own': (context) => Own(),
        'translation': (context) => Translation(),
        'MyReference': (context) => MyReference(),
        'DeleteOwn': (context) => DeleteOwn(),
        'FilterPage': (context) => FilterPage(),
        'UserCabinet': (context) => UserCabinet(),
        'InfoInDate': (context) => InfoInDate(),
        // 'MyReport': (context) => MyReport(),
      },
    );
  }
}
