import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/screens/address_book.dart';
import 'package:udhar_app/screens/recieved_udhar_requests.dart';
import 'package:udhar_app/screens/splash.dart';
import 'package:udhar_app/screens/sent_udhar_requests.dart';
import 'package:udhar_app/screens/test_screen.dart';
import 'package:udhar_app/screens/users_list.dart';
import 'screens/auth.dart';
import 'screens/welcome.dart';
import './screens//sent_udhar_requests.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Udhaar Please',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              // return const AddressBook();
              return const WelcomeScreen();
            }
            return const AuthScreen();
            // return const WelcomeScreen();
          }),
    );
  }
}
