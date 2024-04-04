import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:udhar_app/screens/pending_recieved_udhars.dart';
import 'package:udhar_app/screens/pending_sent_udhars.dart';
import 'package:udhar_app/screens/recieved_udhar_requests.dart';
import 'package:udhar_app/screens/sent_udhar_requests.dart';
import 'package:udhar_app/screens/users_list.dart';
import 'package:udhar_app/widgets/appbar.dart';
import 'package:udhar_app/widgets/slider_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> ls = [""];
  String? _appBarTitle;

  int _selectedIndex = 0;
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  final List<Widget> _pages = [
    const SentUdharRequests(),
    const RecievedUdharRequests(),
    const UserList(),
    const PendingSentUdhars(),
    const PendingRecievedUdhars(),
  ];

  void _onItemTapped(int index) {
    _setAppBarContent(index);

    setState(() {
      _selectedIndex = index;
    });
  }

  void _setAppBarContent(int index) {
    switch (index) {
      case 0:
        setState(() {
          _appBarTitle = "Sent Udhar Requests";
        });
        break;
      case 1:
        setState(() {
          _appBarTitle = "Recieved Udhar Requests";
        });
        break;
      case 2:
        setState(() {
          _appBarTitle = "New Request";
        });
        break;
      case 3:
        setState(() {
          _appBarTitle = "Udhars Given";
        });
        break;
      case 4:
        setState(() {
          _appBarTitle = "Udhars Taken";
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    _setAppBarContent(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: topAppBar,
      body: SliderDrawer(
        key: _key,
        appBar: SliderAppBar(
          appBarColor: const Color.fromRGBO(58, 66, 86, 1.0),
          appBarHeight: 90,
          drawerIconSize: 30,
          drawerIconColor: Colors.yellowAccent,
          title: Text(
            _appBarTitle.toString(),
            style: const TextStyle(
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        slider: Sliderview(
          drawerkey: _key,
          changeIndex: _onItemTapped,
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.yellowAccent),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_in_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
