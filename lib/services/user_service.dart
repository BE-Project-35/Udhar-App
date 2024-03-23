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
}
