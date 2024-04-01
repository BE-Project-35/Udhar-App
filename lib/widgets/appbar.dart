import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final topAppBar = AppBar(
  backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
  elevation: 0.1,
  title: const Text(
    'Udhar please',
    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  ),
  actions: [
    IconButton(
      color: const Color.fromARGB(255, 255, 255, 255),
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      icon: const Icon(
        Icons.exit_to_app,
      ),
    ),
  ],
);
