import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meribhasha/Components/ReusableCard.dart';
import 'package:meribhasha/Screens/front.dart';
import 'package:meribhasha/Screens/saledetails.dart';
import 'package:meribhasha/Utilities/translateOrders.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../constants.dart';

class qrCode extends StatefulWidget {
  static String id = '/qrcode';

  @override
  _qrCodeState createState() => _qrCodeState();
}

class _qrCodeState extends State<qrCode> {
  static TranslateOrders traslateOrders = TranslateOrders();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'One4@LL',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Shyam Grocery',
              style: kTitleResult,
            ),
          ),
          Text(
            'SCAN  ME',
            style: TextStyle(
              letterSpacing: 7.0,
              fontSize: 20,
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: QrImage(
              backgroundColor: Colors.white,
              data: "123456",
              version: QrVersions.auto,
//              embeddedImage: AssetImage('assets/images/test.jpg'),
              size: 300.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
//                onPressed: () async => {
//                  await print(traslateOrders.getTranslatedOrders().toString()),
                onPressed: () => {
                  Navigator.pushNamed(context, FrontPage.id),
                },
                disabledBorderColor: Colors.cyanAccent,
                focusColor: Colors.black,
//                      textColor: Colors.white,
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3.0,
                ),
                child: Text(
                  "Go to Orders",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              OutlineButton(
                onPressed: () => {
                  Navigator.pushNamed(context, SaleDetails.id),
                },
                disabledBorderColor: Colors.cyanAccent,
                focusColor: Colors.black,
//                      textColor: Colors.white,
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3.0,
                ),
                child: Text(
                  "Go to Sales",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
