// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionTile extends StatelessWidget {
  String name;
  String status;
  int amount;
  String message;

  TransactionTile({
    super.key,
    required this.name,
    required this.status,
    required this.amount,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24)),
            ),
            // child: Icon(Icons.autorenew, color: Colors.white),
            child: Text(
              amount.toString(),
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(status, style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: Icon(Icons.arrow_right_outlined,
              color: Colors.white24, size: 30.0),
        ),
      ),
    );
  }
}
