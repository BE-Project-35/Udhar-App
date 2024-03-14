import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final DatabaseReference dbref = FirebaseDatabase.instance.ref();

  void _test() {
    final currentUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> m = {"name": currentUser?.email, "age": 10};
    dbref.child("users").push().set(m).then((value) {
      print("success");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _test, child: const Text("button"));
  }
}
