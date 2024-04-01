import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udhar_app/screens/recieved_udhar_requests.dart';
import 'package:udhar_app/screens/sent_udhar_requests.dart';
import 'package:udhar_app/screens/users_list.dart';
import 'package:udhar_app/widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const SentUdharRequests(),
    const RecievedUdharRequests(),
    const UserList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.yellowAccent),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_unread),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
