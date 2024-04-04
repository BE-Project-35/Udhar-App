// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/widgets/appbar.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen(
      {super.key,
      required this.amount,
      required this.transactionid,
      required this.borrowername,
      required this.lenderName,
      required this.endDate,
      required this.status,
      this.acceptUdhar,
      this.rejectUdhar});
  int amount;
  String transactionid;
  String borrowername;
  String lenderName;
  Function(String, String)? acceptUdhar;
  Function(String)? rejectUdhar;
  String endDate;
  String status;
  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  TransactionService ts = TransactionService();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 110,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '\u{20B9}${widget.amount}',
                style: TextStyle(fontSize: 100, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.all(20),
            color: const Color.fromRGBO(58, 66, 86, 1.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(left: 0),
                  child: Text(
                    "Transaction ID : ${widget.transactionid}",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0, right: 100),
                  margin: EdgeInsets.only(left: 0),
                  child: Text(
                    "Borrower Name : ${widget.borrowername}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 100),
                  child: Text(
                    "Lender Name : ${widget.lenderName}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    widget.endDate,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, bottom: 20, right: 150),
                  child: Text(
                    widget.status,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          widget.lenderName == currentUser!.email
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ts.updateStatus(widget.transactionid, "accepted");
                          Navigator.pop(context);
                        },
                        child: Text("Accept Udhaar")),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ts.deleteTransaction(widget.transactionid);
                          Navigator.pop(context);
                        },
                        child: Text("Reject Udhaar"))
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    ts.deleteTransaction(widget.transactionid);
                    Navigator.pop(context);
                  },
                  child: Text("Delete your request"))
        ],
      ),
    );
  }
}
