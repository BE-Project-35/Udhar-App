import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/udhar_transaction.dart';
import 'package:firebase_database/firebase_database.dart';
import '../services/transaction_service.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  _TestState() {
    // getUsers();

    // Set up a real-time event listener to listen for changes in the 'users' node
    // FirebaseDatabase.instance.ref('udhar-transaction').onValue.listen((event) {
    //   // Call getUsers() whenever there is a change in the database
    //   getUsers();
    // });
  }
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();
  TransactionService ts = TransactionService();
  // List<UdharTransaction> _itemList = [];
  // Query dref = FirebaseDatabase.instance.ref().child('udhar_transactions');

  // void _test() {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   Map<String, dynamic> m = {
  //     "borrowerID": "123",
  //     "recieverID": "234",
  //     "amount": 1
  //   };
  //   dbref.child("udhar-transaction").push().set(m).then((value) {
  //     print("success");
  //   });
  // }

//  void _retrieveItemList() {
//   dbref.onValue.listen((event) {
//     if (event.snapshot.value != null) {
//       Map<dynamic, dynamic> values = event.snapshot.value;
//       List<UdharTransaction> itemList = [];
//       values.forEach((key, value) {
//         itemList.add(UdharTransaction.fromJson(value));
//       });
//       setState(() {
//         _itemList = itemList;
//       });
//     }
//   });
// }\\

  createTransaction() {
    String x = DateTime.now().toString();
    print("entering here");
    try {
      ts.sendUdharRequest("1234", "2345", 0, 4, x);
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  final List<UdharTransaction> list = [];

  // getUsers() async {
  //   final snapshot =
  //       await FirebaseDatabase.instance.ref('udhar-transaction').get();

  //   final map = snapshot.value as Map<dynamic, dynamic>;
  //   list.clear();
  //   map.forEach((key, value) {
  //     final user = UdharTransaction.fromJson(value);
  //     setState(() {
  //       list.add(user);
  //     });
  //   });

  //   print("success");
  //   print(list[0].amount);
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: createTransaction,
      child: const Text("hi"),
    );
  }
}
