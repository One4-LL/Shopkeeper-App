import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SaleDetails extends StatefulWidget {
  static String id = "/sale";
  @override
  _SaleDetailsState createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  final _firestore = Firestore.instance;
  var sale = {
    "Rice": "60kg",
    "Wheat": "35kg",
    "Barley": "20kg",
    "Sarso": "10kg"
  };

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
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Shyam Grocery',
              style: kTitleResult,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '18/01/20',
              style: kItemsStyle,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('SaleDetails').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                  ),
                );
              }
              final items = snapshot.data.documents;
              List<DataRow> salesWidget = [];

              for (var item in items) {
                debugPrint(item.toString());
                for (var each in item.data['Daily Expense'].keys) {
                  final itemWidget = DataRow(
                    cells: [
                      DataCell(
                        Text(
                          each,
                          style: kItemsStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          item.data['Daily Expense'][each].toString(),
                          style: kItemsStyle,
                        ),
                      ),
                    ],
                  );
                  salesWidget.add(itemWidget);
                }
              }
              return Expanded(
                child: DataTable(columns: [
                  DataColumn(
                    label: Text(
                      "Item",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    numeric: false,
                    tooltip: "Name of Item",
                  ),
                  DataColumn(
                    label: Text(
                      "Quantity",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    numeric: false,
                    tooltip: "Quantity of item",
                  ),
                ], rows: salesWidget),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("Predictions:", style: kOrderStyle),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('SaleDetails').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                  ),
                );
              }
              final items = snapshot.data.documents;
              List<DataRow> salesWidget = [];

              for (var item in items) {
                debugPrint(item.toString());
                for (var each in item.data['stocks'].keys) {
                  final itemWidget = DataRow(
                    cells: [
                      DataCell(
                        Text(
                          each,
                          style: kItemsStyle,
                        ),
                      ),
                      DataCell(
                        Text(
                          item.data['stocks'][each].toString(),
                          style: kItemsStyle,
                        ),
                      ),
                    ],
                  );
                  salesWidget.add(itemWidget);
                }
              }
              return Expanded(
                child: DataTable(columns: [
                  DataColumn(
                    label: Text(
                      "Item",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    numeric: false,
                    tooltip: "Name of Item",
                  ),
                  DataColumn(
                    label: Text(
                      "Date to last",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    numeric: false,
                    tooltip: "Quantity of item",
                  ),
                ], rows: salesWidget),
              );
            },
          )
        ],
      ),
    );
  }
}
