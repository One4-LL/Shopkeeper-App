import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meribhasha/Components/ReusableCard.dart';
import 'package:meribhasha/constants.dart';

class FrontPage extends StatefulWidget {
  static String id = '/';

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
//  String messageText;

  @override
  void initState() {
    // TODO: implement initState
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Shyam Grocery',
              style: kTitleResult,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('TransOrders').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final items = snapshot.data.documents;
//              debugPrint(snapshot.data.hashCode.toString());
              List<ReusableCard> itemsWidget = [];
              for (var item in items) {
                var total = item.data['cost'];
//                debugPrint(item.hashCode.toString());
                var uid = item.hashCode.toString();
                final itemCatg = item.data["userOrder"].keys;
                List<DataRow> listItems = [];
                for (var value in itemCatg) {
                  debugPrint(value);
                  if (value != null && value != ' ') {
                    final listWidget = DataRow(
                      cells: [
                        DataCell(
                          Text(
                            value ?? '',
                            style: kItemsStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            item.data['userOrder'][value].toString() ?? '',
                            style: kItemsStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            item.data['userPrice'][value].toString() ?? '',
                            style: kItemsStyle,
                          ),
                        ),
                      ],
                    );
                    listItems.add(listWidget);
                  }
                }

                final itemWidget = ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                            ),
                            Text(
                              "ORDER ID : $uid",
                              style: TextStyle(
                                color: Colors.white,
//                            fontFamily: 'Pacifico',
                                fontSize: 12,
                                letterSpacing: 2.0,
                              ),
                            ),
                            Text(
                              "12345",
                              style: TextStyle(
                                color: Colors.white,
//                            fontFamily: 'Pacifico',
                                fontSize: 12,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                        DataTable(columns: [
                          DataColumn(
                            label: Text(
                              "ITEMS",
                              style: kOrderText,
                            ),
                            numeric: false,
                            tooltip: "Items List",
                          ),
                          DataColumn(
                            label: Text(
                              "QUANTITY",
                              style: kOrderText,
                            ),
                            numeric: false,
                            tooltip: "Quantity",
                          ),
                          DataColumn(
                            label: Text(
                              "PRICE(in Rs)",
                              style: kOrderText,
                            ),
                            numeric: false,
                            tooltip: "Items List",
                          ),
                        ], rows: listItems
//                            [
//                          DataRow(cells: listItems
//                            [
//                              DataCell(Text("Rice", style: kItemsStyle)),
//                              DataCell(Text("1kg", style: kItemsStyle)),
//                              DataCell(Text("40", style: kItemsStyle)),
//                            ],
//                           ),
//                          ],
                            ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () async => {
                                await Firestore.instance.runTransaction(
                                    (Transaction myTransaction) async {
                                  await myTransaction.delete(item.reference);
                                  debugPrint("Pressed VERIFY");
                                })
                              },
//                      color: Colors.pinkAccent,
                              disabledBorderColor: Colors.cyanAccent,
                              focusColor: Colors.black,
//                      textColor: Colors.white,
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 3.0,
                              ),
                              child: Text(
                                "VERIFY",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text("Total = $total", style: kItemsStyle)
                          ],
                        )
                      ],
                    ));
                itemsWidget.add(itemWidget);
              }
              return Expanded(
                child: ListView(
                  children: itemsWidget,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
