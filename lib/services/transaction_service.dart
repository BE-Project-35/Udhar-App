import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/udhar_transaction.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/udhar_transaction.dart';

class TransactionService {
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();
  var uuid = Uuid();

  void sendUdharRequest(String bID, String lID, int amount, int roi, String end,
      String borrowerName, String lenderName) async {
    print(end);
    String uid = uuid.v4();
    UdharTransaction udhar = UdharTransaction(
        transactionID: uid,
        borrowerID: bID,
        lenderID: lID,
        ROI: roi,
        amount: amount,
        requestedDt: end,
        status: "requested",
        end: end,
        borrowerName: borrowerName,
        lenderName: lenderName);
    Map<String, dynamic> udharData = udhar.toJson();

    await dbref.child("transactions").push().set(udharData);

    print('udhar request sent successfully');
  }

  Stream<List<UdharTransaction>> getSentUdharRequests() {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    return dbref.child('transactions').onValue.map((event) {
      List<UdharTransaction> requestList = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        values!.forEach((key, value) {
          if (value['borrowerID'] == currentUser.uid) {
            requestList.add(UdharTransaction.fromJson(value));
          }
          print(requestList);
          // requestList.add(UdharTransaction.fromJson(value));
        });
      }
      return requestList;
    });
  }

  Stream<List<UdharTransaction>> getRecievedUdharRequests() {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    return dbref.child('transactions').onValue.map((event) {
      List<UdharTransaction> requestList = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        values!.forEach((key, value) {
          if (value['lenderID'] == currentUser.uid) {
            requestList.add(UdharTransaction.fromJson(value));
          }
          print(requestList);
          // requestList.add(UdharTransaction.fromJson(value));
        });
      }
      return requestList;
    });
  }
}
