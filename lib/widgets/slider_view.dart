// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:udhar_app/services/user_service.dart';

class Sliderview extends StatelessWidget {
  Sliderview(
      {super.key,
      required this.drawerkey,
      this.selectedIndex,
      this.changeIndex});

  GlobalKey<SliderDrawerState> drawerkey;
  int? selectedIndex;
  Function(int)? changeIndex;
  final currentUID = FirebaseAuth.instance.currentUser!.uid;
  final currentEmail = FirebaseAuth.instance.currentUser!.email;
  late Future<String?> currentURL = UserService().getURLfromID(currentUID);
  // void getemail(String id) async {
  //   currentURL = UserService().readValueById(id);
  // }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void goToHome() {
    drawerkey.currentState!.closeSlider();
  }

  void sendRequest() {
    drawerkey.currentState!.closeSlider();
    changeIndex!(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(58, 66, 86, 1.0),
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: currentURL,
            builder: (context, snapshot) {
              print("${snapshot.data} hello");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                return CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        Image.network(snapshot.data.toString()).image,
                  ),
                );
              } else {
                return Text("no data found");
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            currentEmail.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...[
            Menu(Icons.home, 'Home', goToHome),
            Menu(Icons.add_circle, 'Send new request', sendRequest),
            Menu(Icons.notifications_active, 'Notification', null),
            Menu(Icons.favorite, 'Udhar Score', null),
            Menu(Icons.settings, 'History', null),
            Menu(Icons.arrow_back_ios, 'LogOut', logout)
          ]
              .map(
                (menu) => _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  onTap: menu.util,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class Menu {
  final IconData iconData;
  final String title;
  Function()? util;

  Menu(this.iconData, this.title, this.util);
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        iconData,
        color: Colors.yellowAccent,
      ),
      onTap: () => onTap?.call(),
    );
  }
}
