import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:udhar_app/models/user.dart';
import '../models/udhar_transaction.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/udhar_transaction.dart';

class UserService {
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();

  Future<String?> readValueById(String id) async {
    DatabaseEvent event = await dbref.child('users').child(id).once();
    DataSnapshot dataSnapshot = event.snapshot;
    // Check if dataSnapshot exists and contains the value
    if (dataSnapshot.value != null) {
      // Cast dataSnapshot.value to Map<String, dynamic>
      Map<dynamic, dynamic> dataMap =
          dataSnapshot.value as Map<dynamic, dynamic>;
      // Access the value using the [] operator with the key 'your_value_key'
      dynamic value = dataMap['email'];
      // Check if the value is not null
      if (value != null) {
        return value.toString();
      }
    }
    return null;
  }

  // Future<List<UdharUser>> getUdharUsers() {
  //   List<UdharUser> itemlist = [];
  //   final currentUser = FirebaseAuth.instance.currentUser;

  //   dbref.child('users').once().then((DataSnapshot snapshot) {
  //         if (snapshot.value != null) {
  //           Map<dynamic, dynamic> values =
  //               snapshot.value as Map<dynamic, dynamic>;

  //           values.forEach((key, value) {
  //             if (value['uid'] != currentUser!.uid) {
  //               itemlist.add(UdharUser.fromJson(value));
  //             }
  //           });
  //         }
  //       }
  //   return itemlist.f;
  // }

  Future<List<UdharUser>> getUdharUsers() async {
    List<UdharUser> userList = [];

    try {
      // Replace 'users' with the name of your table in the database
      DataSnapshot snapshot = await dbref.child('users').get();

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          userList.add(UdharUser.fromJson(
              value)); // Replace UdharUser.fromJson with your parsing logic
        });
      }
    } catch (error) {
      // Handle errors if any
      print("Error: $error");
    }

    return userList;
  }

  //void _retrieveItemList() {
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
}
