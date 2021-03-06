import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:speech_recognition/speech_recognition.dart';

import '../constants.dart';

class Udhaar extends StatefulWidget {
  static String id = '/udhaar';
  @override
  _UdhaarState createState() => _UdhaarState();
}

class _UdhaarState extends State<Udhaar> {
  int number = 0;
  String name;
  int amount;
  SpeechRecognition _speechRecognition;
  String status;

  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  var udhaarDetails = {
    "RAM": {
      'amount': 40,
    },
    "SHYAM": {
      'amount': 140,
    },
    "KAMAL": {
      'amount': 30,
    },
    "UJWAL": {
      'amount': 34,
    },
    "ISHANK": {
      'amount': 45,
    },
    "RAGHAV": {
      'amount': 40,
    },
    "AYUSH": {
      'amount': 30,
    },
  };
  var amt;
  var ans;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    takePermission();
    initSpeechRecognizer();
    setState(() {
      number = 0;
    });
  }

  takePermission() async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.requestPermissions([
      Permission.RECORD_AUDIO,
    ]);
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((bool result) => setState(
          () => _isAvailable = result,
        ));

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  void doTask() {
    debugPrint(resultText);
    ans = resultText.split("in");
//    var ans2 = new Map();
//    for (var i = 0; i < ans.length; i++) {
//      var temp = ans[i];
//      var temp2 = temp.split("in");
//      ans2[(temp2[1]).trim()] = temp2[0].trim();
//    }
    amt = ans[0].split(' ')[1];
    debugPrint(amt.toString() + " " + ans[1].toString());
//    debugPrint(udhaarDetails[ans[1].toString()]['amount'].toString());
//    debugPrint(udhaarDetails['ramesh'].toString());
    ans[1] = ans[1].trim().toUpperCase();
    debugPrint("The result " + ans[1].toString());
    setState(() {
      udhaarDetails[ans[1]]['amount'] =
          udhaarDetails[ans[1]]['amount'] + int.parse(amt);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> udhaarWidget = [];
    number = 0;
    for (var item in udhaarDetails.keys) {
      number = number + 1;
      debugPrint(item.toString());
//      for (var each in item.data['Daily Expense'].keys) {
      final personWidget = DataRow(
        cells: [
          DataCell(
            Text(
              number.toString() ?? '',
              style: kItemsStyle,
            ),
          ),
          DataCell(
            Text(
              item.toString() ?? '',
              style: kItemsStyle,
            ),
          ),
          DataCell(
            Text(
              udhaarDetails[item]["amount"].toString() ?? '',
              style: kItemsStyle,
            ),
          ),
          DataCell(
            RaisedButton(
              child: Text("Paid"),
              onPressed: () {
                setState(() {
                  udhaarDetails[item]['amount'] = 0;
                });
              },
            ),
          ),
        ],
      );
      udhaarWidget.add(personWidget);
//      }
    }

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
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Shyam Grocery',
              style: kTitleResult,
            ),
          ),
          Expanded(
            child: DataTable(columns: [
              DataColumn(
                label: Text(
                  "Uno.",
                  style: kOrderText,
                ),
                numeric: false,
                tooltip: "Udhaar number",
              ),
              DataColumn(
                label: Text(
                  "Name",
                  style: kOrderText,
                ),
                numeric: false,
                tooltip: "Name of Person",
              ),
              DataColumn(
                label: Text(
                  "Total(₹)",
                  style: kOrderText,
                ),
                numeric: true,
                tooltip: "Items List",
              ),
              DataColumn(
                label: Text(
                  " ",
                  style: kOrderText,
                ),
                numeric: false,
                tooltip: "Payment",
              ),
            ], rows: udhaarWidget),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                splashColor: Colors.blue,
                heroTag: 'btn1',
                child: Icon(Icons.cancel),
                backgroundColor: Colors.greenAccent,
                onPressed: () {
                  if (_isListening) {
                    _speechRecognition.cancel().then((result) => setState(() {
                          _isListening = result;
                          resultText = "";
                        }));
                  }
                },
              ),
              FloatingActionButton(
                heroTag: 'btn2',
                child: Icon(Icons.mic),
                backgroundColor: Colors.blue,
                onPressed: () {
                  if (_isAvailable && !_isListening) {
                    _speechRecognition
                        .listen(locale: "hi_IN")
                        .then((result) {});
                  }
                },
              ),
              FloatingActionButton(
                mini: true,
                heroTag: 'btn3',
                child: Icon(Icons.stop),
                backgroundColor: Colors.purple,
                onPressed: () {
                  doTask();
                  if (_isListening) {
                    _speechRecognition.stop().then(
                          (result) => setState(() {
                            _isListening = result;
                          }),
                        );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.cyanAccent[100],
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Text(
              resultText,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),

//        ],
//      ),
        ],
      ),
    );
  }
}
