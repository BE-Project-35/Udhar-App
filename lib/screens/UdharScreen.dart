// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udhar_app/services/auth_service.dart';
import 'package:udhar_app/services/transaction_service.dart';
import 'package:udhar_app/widgets/appbar.dart';

class UdharScreen extends StatefulWidget {
  UdharScreen({
    super.key,
    required this.amount,
    required this.transactionid,
    required this.borrowername,
    required this.lenderName,
    required this.endDate,
    required this.status,
  });
  int amount;
  String transactionid;
  String borrowername;
  String lenderName;

  String endDate;
  String status;
  @override
  State<UdharScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<UdharScreen> {
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
          Card(
            elevation: 10,
            margin: EdgeInsets.all(20),
            color: Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Transaction ID : ${widget.transactionid}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Borrower Name : ${widget.borrowername}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Lender Name : ${widget.lenderName}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.endDate,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.status,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.lenderName == currentUser!.email
                  ? ElevatedButton(
                      onPressed: () {
                        ts.updateStatus(widget.transactionid, "completed");
                        Navigator.pop(context);
                      },
                      child: Text("Udhaar returned"))
                  : ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Claim Return")),
            ],
          )
        ],
      ),
    );
  }
}
