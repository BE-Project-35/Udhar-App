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

  void sendUdharRequest(
      String lID, int amount, int roi, String end, String lenderName) async {
    print(end);
    final currentUser = FirebaseAuth.instance.currentUser;

    String uid = uuid.v4();
    UdharTransaction udhar = UdharTransaction(
        transactionID: uid,
        borrowerID: currentUser!.uid,
        lenderID: lID,
        ROI: roi,
        amount: amount,
        requestedDt: end,
        status: "requested",
        end: end,
        borrowerName: currentUser.email.toString(),
        lenderName: lenderName);
    Map<String, dynamic> udharData = udhar.toJson();

    await dbref.child("transactions").child(uid).set(udharData);

    print('udhar request sent successfully');
  }

  void updateStatus(String id, String status) {
    dbref.child('transactions').child(id).child('status').set(status);
  }

  void deleteTransaction(String id) {
    dbref.child('transactions').child(id).remove();
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
          if (value['borrowerID'] == currentUser.uid &&
              value['status'] == "requested") {
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
          if (value['lenderID'] == currentUser.uid &&
              value['status'] == "requested") {
            requestList.add(UdharTransaction.fromJson(value));
          }
          print(requestList);
          // requestList.add(UdharTransaction.fromJson(value));
        });
      }
      return requestList;
    });
  }

  Stream<List<UdharTransaction>> getPendingUdharsGiven() {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    return dbref.child('transactions').onValue.map((event) {
      List<UdharTransaction> requestList = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        values!.forEach((key, value) {
          if (value['lenderID'] == currentUser.uid &&
              value['status'] == "accepted") {
            requestList.add(UdharTransaction.fromJson(value));
          }
          print(requestList);
          // requestList.add(UdharTransaction.fromJson(value));
        });
      }
      return requestList;
    });
  }

  Stream<List<UdharTransaction>> getPendingUdharsTaken() {
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    return dbref.child('transactions').onValue.map((event) {
      List<UdharTransaction> requestList = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        values!.forEach((key, value) {
          if (value['borrowerID'] == currentUser.uid &&
              value['status'] == "accepted") {
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
