import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './test_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('udhar please'),
          actions: [
            IconButton(
              onPressed: () {
                getName();
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
          child: Test(),
        ));
  }

  void getName() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print(currentUser?.email);
    }
  }
}
