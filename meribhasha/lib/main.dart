import 'package:flutter/material.dart';
import 'package:meribhasha/Screens/front.dart';
import 'package:meribhasha/Screens/qrgen.dart';
import 'package:meribhasha/Screens/saledetails.dart';
import 'package:meribhasha/Screens/udhaar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        initialRoute: qrCode.id,
        routes: {
          qrCode.id: (context) => qrCode(),
          FrontPage.id: (context) => FrontPage(),
          SaleDetails.id: (context) => SaleDetails(),
          Udhaar.id: (context) => Udhaar(),
        }
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
