import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/udhar_transaction.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();
  var uuid = Uuid();

  void sendUdharRequest(
      String bID, String lID, int amount, int roi, String end) async {
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
    );
    Map<String, dynamic> udharData = udhar.toJson();

    await dbref.child("transactions").push().set(udharData);

    print('udhar request sent successfully');
  }
}
