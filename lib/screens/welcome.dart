import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/screens/home.dart';
import 'package:udhar_app/screens/sent_udhar_requests.dart';
import './test_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Home(),
    ));
  }
}
