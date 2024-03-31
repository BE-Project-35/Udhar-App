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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 3, 14),
          title: const Text('Udhar please', 
          style:TextStyle (color:Color.fromARGB(255,255, 255,255)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: const Center(
          child: Home(),
        ));
  }
}
